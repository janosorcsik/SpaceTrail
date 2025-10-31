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
    var workspaces: [Workspace] = [
        Workspace(id: 1, apps: []),
        Workspace(id: 2, apps: []),
        Workspace(id: 3, apps: []),
        Workspace(id: 4, apps: [])
    ]

    var selectedWorkplaceId = 1
}
