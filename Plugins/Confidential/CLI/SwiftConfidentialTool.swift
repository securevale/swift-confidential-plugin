import PackagePlugin

enum SwiftConfidentialTool {

    static func instance(for context: Context) throws -> ExecutableTool {
        try context.tool(named: "swift-confidential")
    }
}
