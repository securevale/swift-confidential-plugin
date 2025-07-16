// swift-tools-version: 5.9

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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.4.1/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "c56ccc134146fca58cc432312812d369c874f1bfbc79e1caace5d791ce214038"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageVersions: [.version("6"), .v5]
)
