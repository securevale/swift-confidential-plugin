import Foundation
import PackagePlugin

// MARK: SPM Support

@main
struct Confidential: BuildToolPlugin {

    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        guard target is SwiftSourceModuleTarget else {
            return []
        }
        guard let configurationFile = locateConfigurationFile(in: target) else {
            return []
        }

        return try createBuildCommands(
            context: context,
            configurationFile: configurationFile
        )
    }

    private func locateConfigurationFile(in target: Target) -> Path? {
        FileManager.default
            .enumerateFiles(at: URL(directoryPath: target.directory.string))
            .map { Path($0.path) }
            .first { path in
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

// MARK: Xcode Support

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension Confidential: XcodeBuildToolPlugin {

    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        guard let configurationFile = locateConfigurationFile(in: context.xcodeProject) else {
            return []
        }

        return try createBuildCommands(
            context: context,
            configurationFile: configurationFile
        )
    }

    private func locateConfigurationFile(in project: XcodeProject) -> Path? {
        /*
         A collection obtained from `project.targets.flatMap(\.dependencies)` call does not
         include targets defined in local Swift packages, thus we cannot reliably perform a
         deep enumeration of the project's main directory without introducing potential
         overlapping configuration files that would result in undefined behavior.
         */
        C.Configuration.expectedFileExtensions
            .map { fileExtension in
                URL(directoryPath: project.directory.string)
                    .appending(fileName: C.Configuration.expectedFileName, with: fileExtension)
                    .path
            }
            .filter(FileManager.default.fileExists(atPath:))
            .map(Path.init)
            .first
    }
}
#endif

// MARK: Common API

private extension Confidential {

    func createBuildCommands(context: Context, configurationFile: Path) throws -> [Command] {
        let confidentialTool = try ConfidentialTool.instance(for: context)
        let outputDir = context.pluginWorkDirectory.appending(C.GeneratedSources.directoryName)
        let outputFile = outputDir.appending(C.GeneratedSources.outputFileName)
        let obfuscateCommand = ConfidentialTool.ObfuscateCommand(
            configuration: configurationFile,
            output: outputFile
        )

        return [
            .buildCommand(
                displayName: "Obfuscate secret literals",
                executable: confidentialTool.path,
                arguments: obfuscateCommand.cliArguments,
                inputFiles: [
                    configurationFile
                ],
                outputFiles: [
                    outputFile
                ]
            )
        ]
    }
}
