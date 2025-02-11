//
//  TodoRepositoryProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import Foundation

package protocol TodoRepositoryProtocol: Sendable {
    /// 保存されているTODOを全件取得する関数
    func fetch() async -> [TodoDTO]

    /// データの追加
    /// - parameters:
    /// - dto: 追加する情報を持ったDTO
    func insert(dto: TodoDTO) async

    /// TODOを削除する関数
    /// - parameters:
    ///   - id: 削除対象のモデルのid
    func delete(id: UUID) async

    /// TODOの更新処理
    /// - parameters:
    ///   - dto: 更新後の情報を持ったDTO
    func update(dto: TodoDTO) async
}

/// TodoRepositoryのプレビュー用Mockクラス
package struct MockTodoRepository: TodoRepositoryProtocol {
    package init() {}

    package func fetch() -> [TodoDTO] {
        var todos = [TodoDTO]()
        for index in 1...3 {
            todos.append(
                TodoDTO(
                    id: UUID(),
                    title: "タイトル \(index)",
                    detail: "詳細 \(index)",
                    isFinish: false
                )
            )
        }
        return todos
    }

    package func insert(dto: TodoDTO) async {
        debugPrint("insert!")
    }

    package func delete(id: UUID) async {
        debugPrint("delete!")
    }

    package func update(dto: TodoDTO) async {
        debugPrint("update!")
    }
}
