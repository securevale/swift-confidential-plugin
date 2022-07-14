import Foundation
import PackagePlugin

@main
struct Confidential: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        guard let sourceModule = target as? SwiftSourceModuleTarget else {
            return []
        }
        guard let configurationPath = sourceModule.files(where: isConfigurationFile).first else {
            return []
        }

        let confidentialTool = try ConfidentialTool.instance(for: context)
        let outputDir = context.pluginWorkDirectory.appending(C.GeneratedSources.directoryName)
        let outputPath = outputDir.appending(C.GeneratedSources.outputFileName)
        let obfuscateCommand = ConfidentialTool.ObfuscateCommand(
            configuration: configurationPath,
            output: outputPath
        )

        return [
            .buildCommand(
                displayName: "Obfuscate secret literals",
                executable: confidentialTool.path,
                arguments: obfuscateCommand.cliArguments,
                inputFiles: [
                    configurationPath
                ],
                outputFiles: [
                    outputPath
                ]
            )
        ]
    }
}

private extension Confidential {

    var isConfigurationFile: (Path) -> Bool {
        return { path in
            guard path.stem == C.Configuration.expectedFileName else {
                return false
            }
            guard C.Configuration.expectedFileExtensions.contains(where: { $0 == path.extension }) else {
                return false
            }

            return true
        }
    }
}
