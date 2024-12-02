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
    /// SceneStateからの実行を前提として、MainActorで実行する
    nonisolated func fetch() -> [TodoModel]

    /// データの追加
    /// - parameters:
    ///  - title: タイトル
    ///  - detail: 詳細情報
    func insert(title: String, detail: String) async

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
