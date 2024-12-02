//
//  TodoRepositoryProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftData
import Foundation

public protocol TodoRepositoryProtocol: Sendable {
    /// 保存されているTODOを全件取得する関数
    func fetch() -> [TodoModel]

    /// データの追加
    /// - parameters:
    ///  - title: タイトル
    ///  - detail: 詳細情報
    func insert(id: UUID, title: String, detail: String) async

    /// TODOを削除する関数
    /// - parameters:
    ///   - id: 削除対象のモデルのid
    func delete(id: UUID) async

    /// TODOの更新処理
    /// - parameters:
    ///   - id: 更新対象のid
    ///   - title: タイトル
    ///   - detail: 詳細
    ///   - isFinish: 完了したかどうか
    func update(id: UUID, title: String, detail: String, isFinish: Bool) async
}

/// TodoRepositoryのプレビュー用Mockクラス
public struct MockTodoRepository: TodoRepositoryProtocol, Sendable {
    public init() {}

    public func fetch() -> [TodoModel] {
        var todos = [TodoModel]()
        for index in 1...3 {
            todos.append(
                TodoModel(
                    id: UUID(),
                    title: "タイトル \(index)",
                    detail: "詳細 \(index)"
                )
            )
        }
        return todos
    }

    public func insert(id: UUID, title: String, detail: String) async {
        debugPrint("insert!")
    }

    public func delete(id: UUID) async {
        debugPrint("delete!")
    }

    public func update(id: UUID, title: String, detail: String, isFinish: Bool) async {
        debugPrint("update!")
    }
}
