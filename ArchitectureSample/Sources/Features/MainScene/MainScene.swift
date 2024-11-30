//
//  MainScene.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI

public struct MainScene: View {
    @State var state: MainSceneState

    public init(state: MainSceneState) {
        self.state = state
    }

    public var body: some View {
        Text("MainScene")
    }
}
