import Foundation

extension URL {

    func appending(fileName: String, with fileExtension: String) -> URL {
        var url = self
        url.append(fileName: fileName, with: fileExtension)

        return url
    }

    mutating func append(fileName: String, with fileExtension: String) {
        if #available(macOS 13.0, *) {
            append(component: fileName, directoryHint: .notDirectory)
        } else {
            appendPathComponent(fileName, isDirectory: false)
        }
        appendPathExtension(fileExtension)
    }
}
