//
//  RouterProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI

@MainActor
public protocol RouterProtocol: Sendable {
    /// AppSceneに対応したViewを型消去して返す関数
    func show(_ scene: AppScene) -> AnyView
}
