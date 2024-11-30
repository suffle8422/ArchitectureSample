//
//  Todo.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation

/// 1件のTodoを表すモデル
public struct TodoModel: Sendable {
    let id: UUID
    let title: String
    let detail: String
    let dueDate: Date
    let isFinish: Bool
}
