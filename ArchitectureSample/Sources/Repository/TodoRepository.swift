//
//  TodoRepository.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Core

public final actor TodoRepository: TodoRepositoryProtocol {
    private init() {}
    public static let shared: TodoRepository = TodoRepository()
}
