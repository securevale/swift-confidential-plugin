enum C {

    enum Configuration {
        static let expectedFileName: String = "confidential"
        static let expectedFileExtensions: [String] = ["yml", "yaml"]
    }

    enum GeneratedSources {
        static let directoryName: String = "ObfuscatedSources"
        static let outputFileName: String = "Confidential.generated.swift"
    }
}
