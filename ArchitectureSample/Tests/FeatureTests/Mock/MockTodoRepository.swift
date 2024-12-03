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

    func fetch() -> [TodoDTO] {
        countFetch += 1
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
    
    func insert(dto: TodoDTO) async {
        countInsert += 1
        debugPrint("insert!")
    }
    
    func delete(id: UUID) async {
        countDelete += 1
        debugPrint("delete!")
    }

    func update(dto: TodoDTO) async {
        countUpdate += 1
        debugPrint("update!")
    }

}
