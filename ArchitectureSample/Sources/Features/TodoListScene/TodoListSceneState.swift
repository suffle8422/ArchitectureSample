//
//  TodoListSceneState.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation
import Observation
import Core

@MainActor
@Observable
public final class TodoListSceneState {
    @ObservationIgnored let router: any RouterProtocol
    let todoRepository: any TodoRepositoryProtocol
    var todos = [TodoModel]()

    public init(
        router: any RouterProtocol,
        todoRepository: any TodoRepositoryProtocol
    ) {
        self.router = router
        self.todoRepository = todoRepository
    }

    func fetchTodos() {
        Task { todos = await todoRepository.fetch() }
    }

    func saveTodo() {
        let uuid = UUID()
        let todo = TodoModel(
            id: uuid,
            title: Date().formattedString,
            detail: uuid.uuidString
        )
        Task {
            await todoRepository.save(model: todo)
            todos = await todoRepository.fetch()
        }
    }
}
