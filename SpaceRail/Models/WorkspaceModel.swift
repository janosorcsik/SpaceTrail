//
//  WorkspaceModel.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import Observation

struct Workspace: Identifiable {
    let id: Int
    let apps: [String]
}

@Observable
class WorkspaceModel {
    var workspaces: [Workspace] = (1...4).map { Workspace(id: $0, apps: []) }

    var selectedWorkspaceId = 1
}
