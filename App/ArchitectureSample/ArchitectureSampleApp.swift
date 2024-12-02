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
    private let router = AppEnvironment.shared.router
    var body: some Scene {
        WindowGroup {
            router.show(.todoListScene)
                .modelContainer(AppEnvironment.shared.modelContainer)
        }
    }
}
