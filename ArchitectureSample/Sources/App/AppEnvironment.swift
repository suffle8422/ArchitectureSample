//
//  AppEnvironment.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftData
import Core
import Repository

/// アプリ全体で共通して利用するインスタンスを保持するコンテナ
@MainActor
public final class AppEnvironment {
    public static let shared: AppEnvironment = AppEnvironment()

    public let modelContainer: ModelContainer
    
    let router: any RouterProtocol = Router()
    let todoRepository: any TodoRepositoryProtocol

    private init() {
        let schema = Schema([TodoModel.self])
        let modelConfiguration = ModelConfiguration(schema: schema)
        modelContainer = try! ModelContainer(for: schema, configurations: modelConfiguration)
        todoRepository = TodoRepository(modelContainer: modelContainer)
    }
}
