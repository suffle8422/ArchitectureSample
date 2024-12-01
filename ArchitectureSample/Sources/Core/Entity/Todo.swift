//
//  Todo.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation

/// 1件のTodoを表すモデル
public struct TodoModel: Hashable, Sendable {
    public let id: UUID
    public let title: String
    public let detail: String
    public let isFinish: Bool

    public init(
        id: UUID,
        title: String,
        detail: String,
        isFinish: Bool = false
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isFinish = isFinish
    }
}
