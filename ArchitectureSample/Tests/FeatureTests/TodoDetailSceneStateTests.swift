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
    let todoModel: TodoModel
    let sceneState: TodoDetailSceneState

    init() {
        todoModel = TodoModel(
            id: UUID(),
            title: "タイトル",
            detail: "詳細"
        )
        self.sceneState = TodoDetailSceneState(
            model: todoModel,
            todoRepository: mockTodoRepository
        )
    }

    @Test
    func toggleFinishFlg() async {
        await sceneState.toggleFinishFlg()
        #expect(!todoModel.isFinish, "isFinishプロパティがfalseになっている")
        #expect(await mockTodoRepository.countUpdate == 1, "update関数が1度だけ呼び出されている")
    }

    @Test
    func deleteTodo() async {
        await sceneState.deleteTodo()
        #expect(await mockTodoRepository.countDelete == 1, "delete関数が1度だけ呼び出されている")
    }
}
