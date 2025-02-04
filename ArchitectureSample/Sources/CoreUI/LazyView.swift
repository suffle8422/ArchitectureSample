//
//  LazyView.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI

/// Viewを強制的に遅延評価させるためのView
/// NavigationLinkの遷移先は即時評価されるので、遷移先のSceneやSceneStateのインスタンスが生成されてしまう
/// このViewを挟むことで即時評価を防ぐ
package struct LazyView<Content: View>: View {
    let build: () -> Content

    package init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    package var body: Content {
        build()
    }
}
