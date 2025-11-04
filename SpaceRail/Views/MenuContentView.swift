//
//  MenuContentView.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 11. 04..
//

import SwiftUI

struct MenuContentView: View {
    var model = WorkspaceService.shared.model

    var body: some View {
        ForEach(model.workspaces) { workspace in
            Button {
                WorkspaceService.shared.setSelectedWorkspace(to: workspace.id)
            } label: {
                Text("Workspace \(workspace.id)")
                if model.selectedWorkspaceId == workspace.id {
                    Image(systemName: "checkmark")
                }
            }
            .keyboardShortcut(
                KeyEquivalent(Character("\(workspace.id)")),
                modifiers: [.control, .option])
        }
        Divider()
        Button("Quit") {
            NSApplication.shared.terminate(nil)
        }
    }
}

#Preview {
    MenuContentView()
}
