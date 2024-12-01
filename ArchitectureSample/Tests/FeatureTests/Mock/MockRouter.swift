//
//  MockRouter.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI
import Core

@MainActor
struct MockRouter: RouterProtocol {
    public func show(_ scene: AppScene) -> AnyView {
        AnyView(Text("MockRouter"))
    }
}
