//
//  AppScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

/// 遷移先に指定できる画面を表すenumクラス
/// 画面の生成に必要な情報もここで受け取る
package enum AppScene: Hashable {
    case todoListScene
    case todoDetailScene(model: TodoDTO)
}
