import Foundation

extension SwiftConfidentialTool {

    struct ObfuscateCommand: Equatable {

        var cliArguments: [String] {
            [
                "obfuscate",
                "--configuration", configuration.path(),
                "--output", output.path()
            ]
        }

        private let configuration: URL
        private let output: URL

        init(configuration: URL, output: URL) {
            self.configuration = configuration
            self.output = output
        }
    }
}
