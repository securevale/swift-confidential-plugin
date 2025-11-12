import Foundation

extension URL {

    init(directoryPath: String) {
        self = .init(filePath: directoryPath, directoryHint: .isDirectory)
    }
}
