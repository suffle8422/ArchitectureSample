//
//  TodoRepository.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation
import Core

/// TODO用のRepository
/// todosプロパティを利用した簡易的な実装になっている
public final actor TodoRepository: TodoRepositoryProtocol {
    private var todos = [TodoModel]()

    public init() {
        Task { await setSampleTodos() }
    }

    public func fetch() -> [TodoModel] {
        return todos
    }
    
    public func save(model: TodoModel) {
        if let index = todos.firstIndex(where: { $0.id == model.id }) {
            todos[index] = model
        } else {
            todos.append(model)
        }
    }
    
    public func delete(id: UUID) {
        todos = todos.filter { $0.id != id }
    }
    
    private func setSampleTodos() {
        var newSampleTodos = [TodoModel]()

        for index in 1...30 {
            newSampleTodos.append(
                TodoModel(
                    id: UUID(),
                    title: "タイトル \(index)",
                    detail: "詳細 \(index)"
                )
            )
        }

        todos = newSampleTodos
    }
}
