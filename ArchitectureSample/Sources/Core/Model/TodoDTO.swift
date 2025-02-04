//
//  TodoDTO.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/03.
//

import Foundation

package struct TodoDTO: Hashable, Sendable {
    package let id: UUID
    package let title: String
    package let detail: String
    package let isFinish: Bool

    package init(id: UUID, title: String, detail: String, isFinish: Bool) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isFinish = isFinish
    }
}
