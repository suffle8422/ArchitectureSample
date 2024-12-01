//
//  TodoDetailScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI

public struct TodoDetailScene: View {
    @State var state: TodoDetailSceneState

    public init(state: TodoDetailSceneState) {
        self.state = state
    }

    public var body: some View {
        VStack {
            Text("id: \(state.model.id.uuidString)")
            Text("タイトル: \(state.model.title)")
            Text("詳細: \(state.model.detail)")
            Text("状態: \(state.model.isFinish ? "完了" : "未完了")")
        }
        .navigationTitle("todo詳細")
    }
}
