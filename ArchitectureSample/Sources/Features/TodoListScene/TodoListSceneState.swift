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

    func fetchTodos() async {
        todos = todoRepository.fetch()
    }

    func insertTodo() async {
        await todoRepository.insert(title: Date().formattedString, detail: "詳細情報")
        todos = todoRepository.fetch()
    }
}
