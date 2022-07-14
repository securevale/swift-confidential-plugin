import Foundation
import PackagePlugin

extension SourceModuleTarget {

    func files(where predicate: (Path) -> Bool) -> [Path] {
        let targetURL = URL(fileURLWithPath: directory.string, isDirectory: true)
        let resourceKeys: Set<URLResourceKey> = [.isDirectoryKey]
        guard
            let enumerator = FileManager.default.enumerator(
                at: targetURL,
                includingPropertiesForKeys: .init(resourceKeys),
                options: [.skipsPackageDescendants]
            )
        else {
            return []
        }

        return enumerator
            .compactMap { $0 as? URL }
            .filter { url in
                guard let resourceValues = try? url.resourceValues(forKeys: resourceKeys) else {
                    return false
                }

                return resourceValues.isDirectory == false
            }
            .map { Path($0.path) }
            .filter(predicate)
    }
}
