//
//  TodoDetailSceneState.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI
import Observation
import Core

@MainActor
@Observable
package final class TodoDetailSceneState {
    var model: TodoDTO
    let todoRepository: any TodoRepositoryProtocol

    var isShownDeleteAlert = false

    package init(
        model: TodoDTO,
        todoRepository: any TodoRepositoryProtocol
    ) {
        self.model = model
        self.todoRepository = todoRepository
    }

    func toggleFinishFlg() async {
        let updatedTodo = TodoDTO(
            id: model.id,
            title: model.title,
            detail: model.detail,
            isFinish: !model.isFinish
        )
        await todoRepository.update(dto: updatedTodo)
        model = updatedTodo
    }

    func deleteTodo() async {
        await todoRepository.delete(id: model.id)
    }
}
