//
//  TodoRepositoryTests.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation
import Testing
@testable import Core
@testable import Repository

actor TodoRepositoryTests {
    let todoRepository: TodoRepository

    init() async {
        todoRepository = TodoRepository()
    }

    @Test
    func fetch() async {
        await todoRepository.setTestTodos()
        let fetchedTodos = await todoRepository.fetch()
        #expect(fetchedTodos.count == 10, "10件全てfetchできている")
    }

    @Test("新規作成時のsave関数のテスト")
    func save_idNotDuplicated() async {
        let todosBeforeSaving = await todoRepository.fetch()
        #expect(todosBeforeSaving.count == 0, "save前はTODOが0件")

        let todo = TodoModel(
            id: UUID(),
            title: "タイトル1",
            detail: "詳細1"
        )

        await todoRepository.save(model: todo)

        let todosAfterSaving = await todoRepository.fetch()
        #expect(todosAfterSaving.count == 1, "save後はtodoが1件")
    }

    @Test("更新時のsave関数のテスト")
    func save_idDuplicated() async throws {
        let id = UUID()
        let todo1 = TodoModel(
            id: id,
            title: "タイトル1",
            detail: "詳細1"
        )
        await todoRepository.save(model: todo1)

        let todosBeforeSaving = await todoRepository.fetch()
        #expect(todosBeforeSaving.count == 1, "save前はTODOが1件")

        let todo2 = TodoModel(
            id: id,
            title: "タイトル2",
            detail: "詳細2"
        )
        await todoRepository.save(model: todo2)

        let todosAfterSaving = await todoRepository.fetch()
        #expect(todosAfterSaving.count == 1, "save後もTODOが1件")

        let targetTodo = try #require(todosAfterSaving.first)
        #expect(targetTodo.title == "タイトル2", "タイトルが更新されている")
        #expect(targetTodo.detail == "詳細2", "詳細が更新されている")
    }

    @Test
    func delete() async {
        let id = UUID()
        let todo1 = TodoModel(
            id: id,
            title: "タイトル1",
            detail: "詳細1"
        )
        await todoRepository.save(model: todo1)

        let todosBeforeDeleting = await todoRepository.fetch()
        #expect(todosBeforeDeleting.count == 1, "delete前はTODOが1件")

        await todoRepository.delete(id: id)

        let todosAfterDeleting = await todoRepository.fetch()
        #expect(todosAfterDeleting.count == 0, "delete後はTODOが0件")



    }
}

private extension TodoRepository {
    func setTestTodos() {
        for index in 1...10 {
            save(model:
                TodoModel(
                    id: UUID(),
                    title: "タイトル \(index)",
                    detail: "詳細 \(index)"
                )
            )
        }
    }
}
