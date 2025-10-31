//
//  AppIconsView.swift
//  SpaceRail
//
//  Created by János Orcsik on 2025. 10. 30..
//

import SwiftUI

struct AppIconsView: View {
    let apps: [String]

    var body: some View {
        HStack(spacing: 6) {
            ForEach(apps, id: \.self) { bundleId in
                Group {
                    if let icon = AppIconService.shared.get(bundleId) {
                        Image(nsImage: icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.tint)
                    } else {
                        Image(systemName: "app.dashed")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.tint.secondary)
                    }
                }
                .frame(width: 32, height: 32)
            }
        }
    }
}
