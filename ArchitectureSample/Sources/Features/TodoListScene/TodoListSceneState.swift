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
    var todos = [TodoDTO]()

    public init(
        router: any RouterProtocol,
        todoRepository: any TodoRepositoryProtocol
    ) {
        self.router = router
        self.todoRepository = todoRepository
    }

    func fetchTodos() async {
        todos = await todoRepository.fetch()
    }

    func insertTodo() async {
        let todo = TodoDTO(
            id: UUID(),
            title: Date().formattedString,
            detail: "詳細情報",
            isFinish: false
        )
        await todoRepository.insert(dto: todo)
        todos = await todoRepository.fetch()
    }
}
