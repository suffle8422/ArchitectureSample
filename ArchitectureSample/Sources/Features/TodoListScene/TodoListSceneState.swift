//
//  TodoListSceneState.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

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

        Task {
            todos = await todoRepository.fetch()
        }
    }
}
