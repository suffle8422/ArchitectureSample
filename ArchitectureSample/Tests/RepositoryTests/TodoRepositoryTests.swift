//
//  TodoRepositoryTests.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation
import SwiftData
import Testing
@testable import Core
@testable import Repository

actor TodoRepositoryTests {
    let todoRepository: TodoRepository

    init() async {
        let schema = Schema([TodoModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try! ModelContainer(for: schema, configurations: modelConfiguration)
        todoRepository = TodoRepository(modelContainer: modelContainer)
    }

    deinit {
    }

    @Test
    func fetch() async {
        await todoRepository.setTestTodos()
        let fetchedTodos = todoRepository.fetch()
        #expect(fetchedTodos.count == 10, "10件全てfetchできている")
    }

    @Test
    func insert() async {
        let todosBeforeInserting = todoRepository.fetch()
        #expect(todosBeforeInserting.count == 0, "insert前はTODOが0件")

        await todoRepository.insert(
            id: UUID(),
            title: "タイトル1",
            detail: "詳細1"
        )

        let todosAfterInserting = todoRepository.fetch()
        #expect(todosAfterInserting.count == 1, "insert後はtodoが1件")
    }

    @Test
    func update() async throws {
        let id = UUID()
        await todoRepository.insert(id: id, title: "タイトル1", detail: "詳細1")

        let todosBeforeUpdating = todoRepository.fetch()
        #expect(todosBeforeUpdating.count == 1, "update前はTODOが1件")

        await todoRepository.update(id: id, title: "タイトル2", detail: "詳細2", isFinish: false)

        let todosAfterUpdating = todoRepository.fetch()
        #expect(todosAfterUpdating.count == 1, "save後もTODOが1件")

        let targetTodo = try #require(todosAfterUpdating.first)
        #expect(targetTodo.title == "タイトル2", "タイトルが更新されている")
        #expect(targetTodo.detail == "詳細2", "詳細が更新されている")
    }

    @Test
    func delete() async {
        let id = UUID()
        await todoRepository.insert(id: id, title: "タイトル1", detail: "詳細1")

        let todosBeforeDeleting = todoRepository.fetch()
        #expect(todosBeforeDeleting.count == 1, "delete前はTODOが1件")

        await todoRepository.delete(id: id)

        let todosAfterDeleting = todoRepository.fetch()
        #expect(todosAfterDeleting.count == 0, "delete後はTODOが0件")



    }
}

private extension TodoRepository {
    func setTestTodos() {
        for index in 1...10 {
            insert(
                id: UUID(),
                title: "タイトル\(index)",
                detail: "詳細\(index)"
            )
        }
    }
}
