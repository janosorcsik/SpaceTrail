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
        // Hide app from Dock and CMD+Tab app lists, and app doesn't steal the focus
        NSApplication.shared.setActivationPolicy(.prohibited)

        checkForAccessibilityPermissions()
    }

    private func checkForAccessibilityPermissions() {
        let trusted = AXIsProcessTrusted()

        if !trusted {
            // Open Accessibility setting
            NSWorkspace.shared.open(
                URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility")!
            )
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
            to: .nsEvents(.keyDown),
            using: { event in
                if PanelService.shared.handleKeyDown(event) {
                    event.cancel()
                }
            })
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
