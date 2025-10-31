//
//  ContentView.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import SwiftUI

struct ContentView: View {
    var model = WorkspaceService.shared.model

    var body: some View {
        HStack(spacing: 20) {
            ForEach(model.workspaces) { workspace in
                HStack(spacing: 8) {
                    Text("\(workspace.id)")
                        .font(.title)
                        .monospaced()
                        .foregroundStyle(workspace.id == model.selectedWorkplaceId
                                         ? AnyShapeStyle(.tint)
                                         : AnyShapeStyle(.foreground))

                    if !workspace.apps.isEmpty {
                        AppIconsView(apps: workspace.apps)
                    }
                }
            }
        }
        .padding(16)
        .glassEffect()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}
