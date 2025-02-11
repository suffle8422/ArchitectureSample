//
//  TodoListScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI
import Core

package struct TodoListScene: View {
    @State var state: TodoListSceneState

    package init(state: TodoListSceneState) {
        self.state = state
    }

    package var body: some View {
        NavigationStack {
            todoListView()
                .navigationTitle("TODOリスト")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: {
                                Task { await state.insertTodo() }
                            },
                            label: { Image(systemName: "plus")}
                        )
                    }
                }
                .navigationDestination(for: AppScene.self) { scene in
                    state.router.show(scene)
                }
                .onAppear {
                    Task { await state.fetchTodos() }
                }
        }
    }
}

private extension TodoListScene {
    func todoListView() -> some View {
        List(state.todos, id: \.self) { todo in
            NavigationLink(value: AppScene.todoDetailScene(model: todo)) {
                Text(todo.title)
                    .strikethrough(todo.isFinish)
            }
        }
    }
}

#Preview {
    TodoListScene(
        state: TodoListSceneState(
            router: MockRouter(),
            todoRepository: MockTodoRepository()
        )
    )
}
