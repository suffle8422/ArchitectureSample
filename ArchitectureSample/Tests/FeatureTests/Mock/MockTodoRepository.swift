//
//  MockTodoRepository.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation
import Core

/// TodoRepositoryのテスト用のモッククラス
/// 各関数の呼び出し回数をカウントする
class MockTodoRepository: TodoRepositoryProtocol, @unchecked Sendable {
    /// 呼び出し回数をカウントするプロパティ
    var countFetch = 0
    var countInsert = 0
    var countDelete = 0
    var countUpdate = 0

    func fetch() -> [TodoModel] {
        countFetch += 1
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
    
    func insert(id: UUID, title: String, detail: String) async {
        countInsert += 1
        debugPrint("insert!")
    }
    
    func delete(id: UUID) async {
        countDelete += 1
        debugPrint("delete!")
    }

    func update(id: UUID, title: String, detail: String, isFinish: Bool) async {
        countUpdate += 1
        debugPrint("update!")
    }

}
