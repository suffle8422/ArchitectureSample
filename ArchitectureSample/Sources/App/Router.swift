//
//  Router.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI
import Core
import MainScene

public struct Router: RouterProtocol {
    init() {}

    @MainActor
    public func show(_ scene: AppScene) -> AnyView {
        let sceneView = makeSceneView(scene)
        return AnyView(sceneView)
    }

    @MainActor
    private func makeSceneView(_ scene: AppScene) -> some View {
        switch scene {
        case .mainScene:
            let state = MainSceneState(todoRepository: AppEnvironment.shared.todoRepositroy)
            return MainScene(state: state)
        }
    }
}
