//
//  AppEnvironment.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Core
import Repository

/// アプリ全体で共通して利用するインスタンスを保持するコンテナ
public final class AppEnvironment: Sendable {
    public static let shared: AppEnvironment = AppEnvironment()

    public let router: any RouterProtocol = Router()
    public let todoRepositroy: any TodoRepositoryProtocol = TodoRepository()
}
