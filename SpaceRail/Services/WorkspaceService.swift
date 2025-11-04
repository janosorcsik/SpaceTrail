//
//  WorkspaceService.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import AppKit
import Combine

final class WorkspaceService {
    static let shared = WorkspaceService()

    private let finderBundleId = "com.apple.finder"

    var model = WorkspaceModel()

    func setSelectedWorkspace(to workspaceId: Int) {
        guard model.selectedWorkplaceId != workspaceId else { return }

        model.selectedWorkplaceId = workspaceId
        updateAppVisibility(workspaceId: workspaceId)
    }

    func moveApp(bundleIdentifier: String, to workspaceId: Int) {
        model.workspaces = model.workspaces.map { workspace in
            let filtered = workspace.apps.filter { $0 != bundleIdentifier }
            let isTarget = workspace.id == workspaceId

            let filteredApps = isTarget ? filtered + [bundleIdentifier] : filtered

            return Workspace(
                id: workspace.id,
                apps: filteredApps,
            )
        }

        updateAppVisibility(workspaceId: model.selectedWorkplaceId)
    }

    func removeClosedApps() {
        let runningAppsBundleIdentifiers = getRunningApps().compactMap(\.bundleIdentifier)

        model.workspaces = model.workspaces.map { workspace in
            let filteredApps = workspace.apps.filter { runningAppsBundleIdentifiers.contains($0) }

            return Workspace(
                id: workspace.id,
                apps: filteredApps,
            )
        }
    }

    private func updateAppVisibility(workspaceId: Int) {
        let appsInWorkspace = model.workspaces.first { $0.id == workspaceId }?.apps ?? []
        let runningApps = getRunningApps()

        let filteredApps = runningApps.filter {
            $0.bundleIdentifier != Bundle.main.bundleIdentifier
        }

        let appsToShow = filteredApps.filter { app in
            guard let bundleId = app.bundleIdentifier else { return false }
            return appsInWorkspace.contains(bundleId)
        }

        for app in appsToShow where app.isHidden {
            app.unhide()
        }

        let appsToHide = filteredApps.filter { app in
            guard let bundleId = app.bundleIdentifier else { return false }
            return !appsInWorkspace.contains(bundleId)
        }

        for app in appsToHide {
            guard let bundleId = app.bundleIdentifier else { continue }

            if bundleId == finderBundleId && appsToShow.isEmpty {
                continue
            }

            if !app.isHidden {
                app.hide()
            }
        }
    }

    private func getRunningApps() -> [NSRunningApplication] {
        NSWorkspace.shared.runningApplications
            .filter { $0.activationPolicy == .regular }
    }
}
