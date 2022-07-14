// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "swift-confidential-plugin",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .plugin(
            name: "Confidential",
            targets: ["Confidential"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "confidential",
            url: "https://github.com/securevale/swift-confidential/releases/download/0.1.0/ConfidentialBinary-macos.artifactbundle.zip",
            checksum: "fd43375b35d57a6c36476b70f968b3cebf2f9fea28d9444addc21c9728ba935c"
        ),
        .plugin(
            name: "Confidential",
            capability: .buildTool(),
            dependencies: ["confidential"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
