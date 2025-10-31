//
//  SpaceRailApp.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import Cocoa
import SwiftUI

@main
struct SpaceRailApp: App {
    init() {
        // Hide app from Dock and CMD+Tab app lists, and app doesn't steal the focus
        NSApplication.shared.setActivationPolicy(.prohibited)

        checkForAccessibilityPermissions()
        registerEventMonitors()
    }

    private func checkForAccessibilityPermissions() {
        let trusted = AXIsProcessTrusted()

        if !trusted {
            // Open Accessibility setting
            NSWorkspace.shared.open(
                URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!
            )
        }
    }

    private func registerEventMonitors() {
        let flagsChangeHandler = PanelService.shared.handleFlagsChanged

        NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged, handler: flagsChangeHandler)
        NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { event in
            flagsChangeHandler(event)
            return event
        }

        let keyDownHandler = PanelService.shared.handleKeyDown

        NSEvent.addGlobalMonitorForEvents(matching: .keyDown, handler: keyDownHandler)
        NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            keyDownHandler(event)
            return event
        }
    }

    var body: some Scene {
        MenuBarExtra("SpaceRail", systemImage: "square.grid.2x2") {
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
