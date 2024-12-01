//
//  TodoListScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI
import Core

public struct TodoListScene: View {
    @State var state: TodoListSceneState

    public init(state: TodoListSceneState) {
        self.state = state
    }

    public var body: some View {
        NavigationStack {
            todoListView()
                .navigationTitle("TODOリスト")
                .navigationDestination(for: AppScene.self) { scene in
                    state.router.show(scene)
                }
                .onAppear {
                    state.fetchTodos()
                }
        }
    }
}

private extension TodoListScene {
    func todoListView() -> some View {
        List(state.todos, id: \.self) { todo in
            NavigationLink(value: AppScene.todoDetailScene(model: todo)) {
                Text(todo.title)
            }
        }
    }
}
