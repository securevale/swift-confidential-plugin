import PackagePlugin

enum ConfidentialTool {

    static func instance(for context: PluginContext) throws -> PluginContext.Tool {
        try context.tool(named: "confidential")
    }
}
