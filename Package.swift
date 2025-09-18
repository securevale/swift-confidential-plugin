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
            url: "https://github.com/securevale/swift-confidential/releases/download/0.4.2/SwiftConfidentialBinary-macos.artifactbundle.zip",
            checksum: "f0d3e54db7b774934cfcafcdbbf86de68154679cd73ca13695c87c9182b13906"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["swift-confidential"]
        )
    ],
    swiftLanguageVersions: [.version("6"), .v5]
)
