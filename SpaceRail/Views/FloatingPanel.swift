//
//  FloatingPanel.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import SwiftUI

class FloatingPanel: NSPanel {
    init(view: () -> some View) {
        super.init(
            contentRect: NSRect(),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: true
        )

        isFloatingPanel = true
        level = .floating
        backgroundColor = .clear
        collectionBehavior = [.canJoinAllSpaces, .stationary, .ignoresCycle]

        contentView = NSHostingView(rootView: view())
    }

    func showPanel() {
        // Always read the current screen size to handle resolution change
        guard let screenFrame = NSScreen.main?.frame else {
            return
        }

        let newFrame = NSRect(
            x: 0,
            y: 0,
            width: screenFrame.width,
            height: screenFrame.height - NSStatusBar.system.thickness
        )

        setFrame(newFrame, display: true)

        orderFront(self)
    }

    func hidePanel() {
        orderOut(self)
    }
}
