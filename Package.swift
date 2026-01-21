// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "swift-confidential-plugin",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .plugin(
            name: "Confidential",
            targets: ["Confidential"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "swift-confidential",
            url: "https://github.com/securevale/swift-confidential/releases/download/0.5.1/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "b910e2e07720ad799c3f4c01fbe876b4a215d44935677445302e1c3bace3a2e6"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageModes: [.v5, .v6]
)
