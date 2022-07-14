# Swift Confidential Plugin

[![Swift](https://img.shields.io/badge/Swift-5.6-red)](https://www.swift.org/download)

A Swift Package Manager build tool plugin that supports obfuscating Swift literals embedded in SwiftPM libraries and executables.

## Usage

Please see [the Swift Confidential documentation](https://github.com/securevale/swift-confidential) for more detailed usage instructions.

### Adding the plugin as a dependency

To use the Swift Confidential plugin with your package, add it to the package's dependencies and then to your target's plugins:

```swift
// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/securevale/swift-confidential-plugin.git", from: "0.1.0")
    ],
    targets: [
        .target(
            // name, dependencies, resources, etc.
            plugins: [
                // other plugins
                .plugin(name: "Confidential", package: "swift-confidential-plugin")
            ]
        )
    ]
)
```

> **NOTE:** Swift 5.6 is required in order to run the plugin.

## Versioning

This project follows [semantic versioning](https://semver.org/). The plugin's releases are synced with [Swift Confidential](https://github.com/securevale/swift-confidential) releases.

## License

This plugin is released under Apache License v2.0 with Runtime Library Exception. 
Please see [LICENSE](LICENSE) for more information.