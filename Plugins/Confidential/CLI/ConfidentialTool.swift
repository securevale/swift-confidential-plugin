import PackagePlugin

enum ConfidentialTool {

    static func instance(for context: Context) throws -> ExecutableTool {
        try context.tool(named: "confidential")
    }
}
