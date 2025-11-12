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

    private func locateConfigurationFile(in target: Target) -> URL? {
        FileManager.default
            .enumerateFiles(at: URL(directoryPath: String(describing: target.directory)))
            .first { url in
                guard url.deletingPathExtension().lastPathComponent == C.Configuration.expectedFileName else {
                    return false
                }
                guard C.Configuration.expectedFileExtensions.contains(url.pathExtension) else {
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

    private func locateConfigurationFile(in project: XcodeProject) -> URL? {
        /*
         A collection obtained from `project.targets.flatMap(\.dependencies)` call does not
         include targets defined in local Swift packages, thus we cannot reliably perform a
         deep enumeration of the project's main directory without introducing potential
         overlapping configuration files that would result in undefined behavior.
         */
        C.Configuration.expectedFileExtensions
            .map { fileExtension in
                project
                    .directoryURL
                    .appending(fileName: C.Configuration.expectedFileName, with: fileExtension)
            }
            .first {
                FileManager.default.fileExists(atPath: $0.path())
            }
    }
}
#endif

// MARK: Common API

private extension Confidential {

    func createBuildCommands(context: Context, configurationFile: URL) throws -> [Command] {
        let confidentialTool = try SwiftConfidentialTool.instance(for: context)
        let outputDir = context.pluginWorkDirectoryURL.appending(component: C.GeneratedSources.directoryName)
        let outputFile = outputDir.appending(component: C.GeneratedSources.outputFileName)
        let obfuscateCommand = SwiftConfidentialTool.ObfuscateCommand(
            configuration: configurationFile,
            output: outputFile
        )

        return [
            .buildCommand(
                displayName: "Obfuscate secret literals",
                executable: confidentialTool.url,
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
