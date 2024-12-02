//
//  TodoListSceneStateTests.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Testing
@testable import Core
@testable import Repository
@testable import TodoListScene

@MainActor
struct TodoListSceneStateTests {
    let mockTodoRepository = MockTodoRepository()
    let sceneState: TodoListSceneState

    init() {
        self.sceneState = TodoListSceneState(
            router: MockRouter(),
            todoRepository: mockTodoRepository
        )
    }

    @Test
    func fetchTodos() async {
        await sceneState.fetchTodos()
        #expect(await mockTodoRepository.countFetch == 1, "fetch関数が1度だけ呼び出される")
    }

    @Test
    func insertTodo() async {
        await sceneState.insertTodo()
        #expect(await mockTodoRepository.countInsert == 1, "insert関数が1度だけ呼ばれる")
    }
}
