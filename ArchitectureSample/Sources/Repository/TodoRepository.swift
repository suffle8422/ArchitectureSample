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
    public func fetch() -> [TodoDTO] {
        let fetchDescriptor = FetchDescriptor<TodoModel>()
        let todos = try? modelContext.fetch(fetchDescriptor)
        guard let todos else { return [] }
        return todos.map { $0.makeDTO() }
    }

    public func insert(dto: TodoDTO) {
        let todoModel = TodoModel(id: dto.id, title: dto.title, detail: dto.detail, isFinish: dto.isFinish)
        modelContext.insert(todoModel)
        try? modelContext.save()
    }

    public func delete(id: UUID) {
        guard let todo = get(id: id) else { return }
        modelContext.delete(todo)
        try? modelContext.save()
    }

    public func update(dto: TodoDTO) {
        guard let todo = get(id: dto.id) else { return }
        todo.title = dto.title
        todo.detail = dto.detail
        todo.isFinish = dto.isFinish
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

