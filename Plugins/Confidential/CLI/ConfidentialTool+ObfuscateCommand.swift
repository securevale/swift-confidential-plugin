import PackagePlugin

extension ConfidentialTool {

    struct ObfuscateCommand: Equatable {

        var cliArguments: [CustomStringConvertible] {
            [
                "obfuscate",
                "--configuration", configuration.string,
                "--output", output.string
            ]
        }

        private let configuration: Path
        private let output: Path

        init(configuration: Path, output: Path) {
            self.configuration = configuration
            self.output = output
        }
    }
}

