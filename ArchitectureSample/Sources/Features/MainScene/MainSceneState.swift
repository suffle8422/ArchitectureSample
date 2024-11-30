//
//  MainSceneState.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Observation
import Core

@MainActor
@Observable
public final class MainSceneState {
    let todoRepository: any TodoRepositoryProtocol

    public init(todoRepository: any TodoRepositoryProtocol) {
        self.todoRepository = todoRepository
    }
}
