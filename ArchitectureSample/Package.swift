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
            .repository,
            .mainScene
        ]
    ),
    .target(name: .core),
    .target(
        name: .repository,
        dependencies: [
            .core
        ]
    ),

    // MARK: - Features
    .target(
        name: .mainScene,
        dependencies: [
            .core,
            .repository
        ],
        path: "\(String.featuresBasePath)/\(String.mainScene)"
    )
]


private extension String {
    static let app = "App"
    static let core = "Core"
    static let repository = "Repository"

    // MARK: Features
    static let mainScene = "MainScene"

    static let featuresBasePath = "Sources/Features"
}

private extension Target.Dependency {
    static let app = Self.target(name: .app)
    static let core = Self.target(name: .core)
    static let repository = Self.target(name: .repository)

    // MARK: Features
    static let mainScene = Self.target(name: .mainScene)
}
