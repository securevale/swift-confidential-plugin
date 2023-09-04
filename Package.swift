// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-confidential-plugin",
    platforms: [
        .macOS(.v10_15)
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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.3.0/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "8761c22e88f21c8a9453a8344306af8ed2b58ae5d5e23d78b5cdc83359a06227"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
