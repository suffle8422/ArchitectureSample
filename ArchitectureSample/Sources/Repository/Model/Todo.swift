//
//  Todo.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation
import SwiftData
import Core

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

    public func makeDTO() -> TodoDTO {
        return TodoDTO(
            id: id,
            title: title,
            detail: detail,
            isFinish: isFinish
        )
    }
}
