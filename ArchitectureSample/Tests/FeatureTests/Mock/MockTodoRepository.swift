//
//  MockTodoRepository.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import Foundation
import Core

actor MockTodoRepository: TodoRepositoryProtocol {
    /// 呼び出し回数をカウントするプロパティ
    var countFetch = 0
    var countSave = 0
    var countDelete = 0

    func fetch() async -> [TodoModel] {
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
    
    func save(model: TodoModel) async {
        countSave += 1
        debugPrint("save!")
    }
    
    func delete(id: UUID) async {
        countDelete += 1
        debugPrint("delete!")
    }
}
