//
//  TodoDetailSceneStateTests.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation
import Testing
@testable import Core
@testable import Repository
@testable import TodoDetailScene

@MainActor
struct TodoDetailSceneStateTests {
    let mockTodoRepository = MockTodoRepository()
    let todo: TodoDTO
    let sceneState: TodoDetailSceneState

    init() {
        todo = TodoDTO(
            id: UUID(),
            title: "タイトル",
            detail: "詳細",
            isFinish: false
        )
        self.sceneState = TodoDetailSceneState(
            model: todo,
            todoRepository: mockTodoRepository
        )
    }

    @Test
    func toggleFinishFlg() async {
        await sceneState.toggleFinishFlg()
        #expect(!todo.isFinish, "isFinishプロパティがfalseになっている")
        #expect(await mockTodoRepository.countUpdate == 1, "update関数が1度だけ呼び出されている")
    }

    @Test
    func deleteTodo() async {
        await sceneState.deleteTodo()
        #expect(await mockTodoRepository.countDelete == 1, "delete関数が1度だけ呼び出されている")
    }
}
