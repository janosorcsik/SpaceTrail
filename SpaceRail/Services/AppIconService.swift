//
//  AppIconService.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import AppKit
import Foundation

class AppIconService {
    static let shared = AppIconService()
    private let cache = NSCache<NSString, NSImage>()

    func get(_ bundleIdentifier: String) -> NSImage? {
        if let cached = cache.object(forKey: bundleIdentifier as NSString) {
            return cached
        }

        guard let appURL = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) else {
            return nil
        }

        let icon = NSWorkspace.shared.icon(forFile: appURL.path)
        icon.size = NSSize(width: 32, height: 32)

        cache.setObject(icon, forKey: bundleIdentifier as NSString)

        return icon
    }
}
