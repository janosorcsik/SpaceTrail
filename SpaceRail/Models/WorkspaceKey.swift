//
//  WorkspaceKey.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 11. 04..
//

enum WorkspaceKey: UInt16 {
    case one = 18
    case two = 19
    case three = 20
    case four = 21

    var workspaceNumber: Int {
        Int(rawValue) - 17
    }
}
