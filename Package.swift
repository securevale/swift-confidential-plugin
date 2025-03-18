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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.4.0/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "74fd57e01302e34027bdce7e99c3d75612341c5e8578360bd3fbc75666b22bf4"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageVersions: [.version("6"), .v5]
)
