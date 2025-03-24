//
//  TopScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2025/02/04.
//

import SwiftUI
import SwiftData

public struct TopScene: View {
    public init() {}

    public var body: some View {
        AppEnvironment.shared.router.show(.todoListScene)
            .modelContainer(AppEnvironment.shared.modelContainer)
    }
}
