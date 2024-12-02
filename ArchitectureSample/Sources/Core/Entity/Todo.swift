//
//  Todo.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation
import SwiftData

/// 1件のTodoを表すモデル
@Model
public class TodoModel {
    @Attribute(.unique) public var id: UUID
    public var title: String
    public var detail: String
    public var isFinish: Bool

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
