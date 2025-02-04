//
//  ArchitectureSampleApp.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI
import SwiftData
import App
import Core

@main
struct ArchitectureSampleApp: App {
    var body: some Scene {
        WindowGroup {
            TopScene()
                .modelContainer(AppEnvironment.shared.modelContainer)
        }
    }
}
