import PackagePlugin

typealias ExecutableTool = PluginContext.Tool

protocol Context {
    var pluginWorkDirectory: Path { get }
    func tool(named name: String) throws -> ExecutableTool
}

extension PluginContext: Context {}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension XcodePluginContext: Context {}
#endif
