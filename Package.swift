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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.2.0/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "303ce7c03eb27656cba908c48974dc656925c6dd605d2774b822ca6254bdfe91"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
