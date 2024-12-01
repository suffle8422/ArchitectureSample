// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

@preconcurrency import PackageDescription

let package = Package(
    name: "ArchitectureSample",
    platforms: [
        .iOS(.v18)
    ],
    dependencies: []
)

package.products = [
    .library(name: .app, targets: [.app])
]

package.targets = [
    .target(
        name: .app,
        dependencies: [
            .core,
            .coreUI,
            .repository,
            .todoListScene,
            .todoDetailScene
        ]
    ),
    .target(name: .core),
    .target(
        name: .coreUI,
        dependencies: [
            .core
        ]
    ),
    .target(
        name: .repository,
        dependencies: [
            .core
        ]
    ),

    // MARK: - Features
    .target(
        name: .todoListScene,
        dependencies: [
            .core,
            .repository
        ],
        path: "\(String.featuresBasePath)/\(String.todoListScene)"
    ),
    .target(
        name: .todoDetailScene,
        dependencies: [
            .core,
            .repository
        ],
        path: "\(String.featuresBasePath)/\(String.todoDetailScene)"
    ),
]


private extension String {
    static let app = "App"
    static let core = "Core"
    static let coreUI = "CoreUI"
    static let repository = "Repository"

    // MARK: Features
    static let todoListScene = "TodoListScene"
    static let todoDetailScene = "TodoDetailScene"

    static let featuresBasePath = "Sources/Features"
}

private extension Target.Dependency {
    static let app = Self.target(name: .app)
    static let core = Self.target(name: .core)
    static let coreUI = Self.target(name: .coreUI)
    static let repository = Self.target(name: .repository)

    // MARK: Features
    static let todoListScene = Self.target(name: .todoListScene)
    static let todoDetailScene = Self.target(name: .todoDetailScene)
}
