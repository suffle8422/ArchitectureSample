//
//  TodoDTO.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/03.
//

import Foundation

public struct TodoDTO: Hashable, Sendable {
    public let id: UUID
    public let title: String
    public let detail: String
    public let isFinish: Bool

    public init(id: UUID, title: String, detail: String, isFinish: Bool) {
        self.id = id
        self.title = title
        self.detail = detail
        self.isFinish = isFinish
    }
}
