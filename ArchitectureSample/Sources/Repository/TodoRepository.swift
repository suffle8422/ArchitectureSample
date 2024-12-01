//
//  TodoRepository.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation
import SwiftData
import Core

@ModelActor
public final actor TodoRepository: TodoRepositoryProtocol, Sendable {
    private nonisolated var modelContext: ModelContext { modelExecutor.modelContext }

    public nonisolated func fetch() -> [TodoModel] {
        let fetchDescriptor = FetchDescriptor<TodoModel>()
        let todos = try? modelContext.fetch(fetchDescriptor)
        return todos ?? []
    }

    public func insert(id: UUID, title: String, detail: String) {
        let todo = TodoModel(id: id, title: title, detail: detail)
        modelContext.insert(todo)
        try? modelContext.save()
    }

    public func delete(id: UUID) {
        guard let todo = get(id: id) else { return }
        modelContext.delete(todo)
        try? modelContext.save()
    }

    public func update(id: UUID, title: String, detail: String, isFinish: Bool) {
        guard let todo = get(id: id) else { return }
        todo.id = id
        todo.title = title
        todo.detail = detail
        todo.isFinish = isFinish
        try? modelContext.save()
    }

    private func get(id: UUID) -> TodoModel? {
        let fetchDescriptor = FetchDescriptor<TodoModel>(
            predicate: #Predicate { $0.id == id }
        )
        let todo = try? modelContext.fetch(fetchDescriptor).first
        return todo
    }
}

