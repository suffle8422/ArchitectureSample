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
public final class TodoDetailSceneState {
    var model: TodoModel
    let todoRepository: any TodoRepositoryProtocol

    var isShownDeleteAlert = false

    public init(
        model: TodoModel,
        todoRepository: any TodoRepositoryProtocol
    ) {
        self.model = model
        self.todoRepository = todoRepository
    }

    func toggleFinishFlg() async {
        await todoRepository.update(
            id: model.id,
            title: model.title,
            detail: model.detail,
            isFinish: !model.isFinish
        )
    }

    func deleteTodo() async {
        await todoRepository.delete(id: model.id)
    }
}
