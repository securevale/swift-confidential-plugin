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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.5.2/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "104b4c05046ae1fb9d54790488112d71730d4afedf1f715869b8fe99edac8f9b"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageModes: [.v5, .v6]
)
