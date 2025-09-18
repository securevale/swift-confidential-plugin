# Swift Confidential Plugin

[![CI](https://github.com/securevale/swift-confidential-plugin/actions/workflows/ci.yml/badge.svg)](https://github.com/securevale/swift-confidential-plugin/actions/workflows/ci.yml)
[![Swift](https://img.shields.io/badge/Swift-6.2%20%7C%206.1%20%7C%206.0%20%7C%205.10%20%7C%205.9-red)](https://www.swift.org/download)

A Swift Package Manager build tool plugin that supports obfuscating Swift literals embedded in libraries and executables.

## Usage

Please see the [Swift Confidential documentation](https://github.com/securevale/swift-confidential) for more detailed usage instructions.

### Adding the plugin as a dependency

You can use this plugin with both SwiftPM and Xcode targets, depending on your needs. Please see the relevant section below for detailed installation instructions.

#### SwiftPM

To use the Swift Confidential plugin with your SwiftPM target, add it to the package's dependencies and then to your target's plugins:

```swift
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        // other dependencies
        .package(url: "https://github.com/securevale/swift-confidential-plugin.git", .upToNextMinor(from: "0.4.0"))
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

#### Xcode

To use the Swift Confidential plugin directly with your Xcode target:

* Add `swift-confidential-plugin` package to your Xcode project. Please refer to the [official documentation](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app) for step-by-step instructions on how to add package dependencies.
* Then, navigate to your target’s `Build Phases` pane, and in the `Run Build Tool Plug-ins` section, click the `+` button, select the `Confidential` plugin, and click the `Add` button.

> [!IMPORTANT]  
> Due to the limitations of XcodeProjectPlugin API, the [`confidential.yml` configuration file](https://github.com/securevale/swift-confidential#configuration) must be located in the Xcode project's top-level directory, meaning that you cannot create distinct sets of secret literals for different Xcode targets. Hopefully, this behavior will be improved in the future.

## Versioning

This project follows [semantic versioning](https://semver.org/). The plugin's releases are synced with [Swift Confidential](https://github.com/securevale/swift-confidential) releases.

## License

This plugin is released under Apache License v2.0 with Runtime Library Exception. 
Please see [LICENSE](LICENSE) for more information.
