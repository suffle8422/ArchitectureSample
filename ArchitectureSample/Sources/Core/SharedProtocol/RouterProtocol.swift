//
//  RouterProtocol.swift
//  ArchitectureSample
//
//  Created by ionishi on 2024/11/30.
//

import SwiftUI

public protocol RouterProtocol: Sendable {
    @MainActor
    func show(_ scene: AppScene) -> AnyView
}
