//
//  SpaceRailApp.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import Cocoa
import SwiftUI
import CGEventSupervisor

@main
struct SpaceRailApp: App {
    init() {
        NSApplication.shared.setActivationPolicy(.accessory)

        checkForAccessibilityPermissions()

        // Hide app from Dock and CMD+Tab app lists, and app doesn't steal the focus
        NSApplication.shared.setActivationPolicy(.prohibited)
    }

    private func checkForAccessibilityPermissions() {
        let trusted = AXIsProcessTrusted()

        if !trusted {
            let alert = NSAlert()
            alert.messageText = "Accessibility Permission Required"
            alert.informativeText = "Please enable accessibility permissions in System Settings, then restart SpaceRail."
            alert.addButton(withTitle: "Open System Settings")
            alert.addButton(withTitle: "Quit")

            let response = alert.runModal()

            if response == .alertFirstButtonReturn {
                NSWorkspace.shared.open(
                    URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!
                )
            }

            NSApplication.shared.terminate(nil)
        } else {
            registerEventMonitors()
        }
    }

    private func registerEventMonitors() {
        CGEventSupervisor.shared.subscribe(
            as: "FlagsChanged",
            to: .nsEvents(.flagsChanged),
            using: PanelService.shared.handleFlagsChanged)

        CGEventSupervisor.shared.subscribe(
            as: "KeyDown",
            to: .nsEvents(.keyDown)
        ) { event in
            if PanelService.shared.handleKeyDown(event) {
                event.cancel()
            }
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
