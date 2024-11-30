//
//  AppEnvironment.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Core
import Repository

/// アプリ全体で共通して利用するインスタンスを保持するクラス
public final class AppEnvironment: Sendable {
    public static let shared: AppEnvironment = AppEnvironment()

    public let todoRepositroy: any TodoRepositoryProtocol
    public let router: any RouterProtocol

    private init(
        todoRepository: any TodoRepositoryProtocol = TodoRepository.shared,
        router: any RouterProtocol = Router()
    ) {
        self.todoRepositroy = todoRepository
        self.router = router
    }
}
