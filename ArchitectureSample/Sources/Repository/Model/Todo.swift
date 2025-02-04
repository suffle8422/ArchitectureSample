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
package class TodoModel {
    @Attribute(.unique) package var id: UUID
    package var title: String
    package var detail: String
    package var isFinish: Bool

    package init(
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

    package func makeDTO() -> TodoDTO {
        return TodoDTO(
            id: id,
            title: title,
            detail: detail,
            isFinish: isFinish
        )
    }
}
