//
//  RouterProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI

@MainActor
package protocol RouterProtocol {
    /// AppSceneに対応したViewを型消去して返す関数
    func show(_ scene: AppScene) -> AnyView
}

/// Routerのプレビュー用Mockクラス
package struct MockRouter: RouterProtocol {
    package init() {}

     package func show(_ scene: AppScene) -> AnyView {
        AnyView(Text("MockRouter"))
    }
}
