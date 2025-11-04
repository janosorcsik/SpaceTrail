//
//  PanelService.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import AppKit

final class PanelService {
    static let shared = PanelService()

    private let floatingPanel: FloatingPanel
    private let overlayModifiers: NSEvent.ModifierFlags = [.control, .option]

    private var focusedAppBundleIdentifier: String?

    private init() {
        floatingPanel = FloatingPanel {
            ContentView()
        }
    }

    func handleFlagsChanged(_ event: NSEvent) {
        if event.modifierFlags.intersection(overlayModifiers) == overlayModifiers {
            focusedAppBundleIdentifier = NSWorkspace.shared.frontmostApplication?.bundleIdentifier

            WorkspaceService.shared.removeClosedApps()

            floatingPanel.showPanel()
        } else {
            floatingPanel.hidePanel()
        }
    }

    func handleKeyDown(_ event: NSEvent) -> Bool {
        guard event.modifierFlags.intersection(overlayModifiers) == overlayModifiers else { return false }
        guard let workspaceKey = WorkspaceKey(rawValue: event.keyCode) else { return false }

        let number = workspaceKey.workspaceNumber

        if event.modifierFlags.contains(.shift) {
            guard let focusedAppBundleIdentifier else { return true }
            WorkspaceService.shared.moveApp(bundleIdentifier: focusedAppBundleIdentifier, to: number)
        } else {
            WorkspaceService.shared.setSelectedWorkspace(to: number)
        }

        return true
    }
}
