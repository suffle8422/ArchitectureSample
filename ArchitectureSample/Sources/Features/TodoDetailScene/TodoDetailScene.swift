//
//  TodoDetailScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/12/01.
//

import SwiftUI
import Core

public struct TodoDetailScene: View {
    @State var state: TodoDetailSceneState
    @Environment(\.dismiss) private var dismiss

    public init(state: TodoDetailSceneState) {
        self.state = state
    }

    public var body: some View {
        Group {
            modelInfoView(model: state.model)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: { state.isShownDeleteAlert = true },
                            label: { Image(systemName: "trash") }
                        )
                    }
                }
        }
        .navigationTitle("todo詳細")
        .alert("",isPresented: $state.isShownDeleteAlert) {
            Button(
                role: .cancel,
                action: {},
                label: { Text("キャンセル") }
            )
            Button(
                role: .destructive,
                action: {
                    Task {
                        await state.deleteTodo()
                        dismiss()
                    }
                },
                label: { Text("削除") }
            )
        } message: {
            Text("このTODOを削除します\nよろしいですか")
        }
    }
}

private extension TodoDetailScene {
    func modelInfoView(model: TodoModel) -> some View {
        VStack {
            Text("id: \(model.id.uuidString)")
            Text("タイトル: \(model.title)")
            Text("詳細: \(model.detail)")
            Text("状態: \(model.isFinish ? "完了" : "未完了")")
        }
    }
}
