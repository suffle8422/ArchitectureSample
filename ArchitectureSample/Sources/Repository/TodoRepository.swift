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

    public init() {}

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
}
