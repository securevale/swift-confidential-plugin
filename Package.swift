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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.5.0/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "a955fa00b32f46cd47a43348bb17a1543fc248b43ccb218e3a3613bd1051757c"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageModes: [.v5, .v6]
)
