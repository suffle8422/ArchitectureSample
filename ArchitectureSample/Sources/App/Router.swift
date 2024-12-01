//
//  Router.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI
import Core
import CoreUI
import TodoListScene
import TodoDetailScene

@MainActor
public struct Router: RouterProtocol {
    public func show(_ scene: AppScene) -> AnyView {
        let sceneView = makeSceneView(scene)
        return AnyView(sceneView)
    }

    private func makeSceneView(_ scene: AppScene) -> any View {
        switch scene {
        case .todoListScene:
            let state = TodoListSceneState(
                router: AppEnvironment.shared.router,
                todoRepository: AppEnvironment.shared.todoRepositroy
            )
            return buildView(TodoListScene(state: state))

        case let .todoDetailScene(model):
            let state = TodoDetailSceneState(
                model: model,
                todoRepository: AppEnvironment.shared.todoRepositroy
            )
            return buildView(TodoDetailScene(state: state))
        }
    }

    private func buildView<Content: View>(_ content: Content) -> some View {
        LazyView(
            ZStack {
                Color.white
                    .ignoresSafeArea(edges: [.bottom])
                content
            }
        )

    }
}
