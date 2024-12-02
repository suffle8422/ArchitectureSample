//
//  MockRouter.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI
import Core

/// Routerのテスト用Mockクラス
@MainActor
struct MockRouter: RouterProtocol {
    public func show(_ scene: AppScene) -> AnyView {
        AnyView(Text("MockRouter"))
    }
}
