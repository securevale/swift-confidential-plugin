import Foundation

extension URL {

    init(directoryPath: String) {
        if #available(macOS 13.0, *) {
            self = .init(filePath: directoryPath, directoryHint: .isDirectory)
        } else {
            self = .init(fileURLWithPath: directoryPath, isDirectory: true)
        }
    }
}
