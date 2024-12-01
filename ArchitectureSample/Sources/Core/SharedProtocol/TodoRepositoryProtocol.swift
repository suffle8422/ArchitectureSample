//
//  TodoRepositoryProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation

public protocol TodoRepositoryProtocol: Sendable {
    /// 保存されているTODOを全件取得する関数
    func fetch() async -> [TodoModel]

    /// 同じidが存在すれば更新、なければ新規作成する関数
    /// - parameters:
    ///   - model: 更新対象の情報を持ったTodoModel
    func save(model: TodoModel) async

    /// TODOを削除する関数
    /// - parameters:
    ///   - id: 削除対象のid
    func delete(id: UUID) async
}
