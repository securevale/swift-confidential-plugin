import Foundation

extension FileManager {

    func enumerateFiles(at directoryURL: URL) -> some Collection<URL> {
        let resourceKeys: Set<URLResourceKey> = [.isDirectoryKey]
        guard
            let enumerator = enumerator(
                at: directoryURL,
                includingPropertiesForKeys: .init(resourceKeys),
                options: [.skipsPackageDescendants]
            )
        else {
            return [URL]()
        }

        return enumerator
            .compactMap { $0 as? URL }
            .filter { url in
                guard let resourceValues = try? url.resourceValues(forKeys: resourceKeys) else {
                    return false
                }

                return resourceValues.isDirectory == false
            }
    }
}
