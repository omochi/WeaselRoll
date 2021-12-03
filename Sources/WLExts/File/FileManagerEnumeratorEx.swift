import Foundation

extension FileManager {
    private struct DirectoryOrFileIterator: IteratorProtocol {
        var fm: FileManager
        var url: URL
        var keys: [URLResourceKey]?
        var options: DirectoryEnumerationOptions

        var stack: [URL]

        mutating func next() -> URL? {
            while true {
                guard let head = stack.first else {
                    return nil
                }
                stack.removeFirst()

                var isDir = false
                guard fm.fileExists(at: head, isDirectory: &isDir) else {
                    continue
                }

                guard isDir else {
                    return head
                }

                if let files = try? fm.relativeContentsOfDirectory(
                    at: head,
                    includingPropertiesForKeys: keys,
                    options: options
                ) {
                    stack += files
                }

                return head
            }
        }
    }

    public func directoryOrFileEnumerator(
        at url: URL,
        includingPropertiesForKeys keys: [URLResourceKey]? = nil,
        options: DirectoryEnumerationOptions = []
    ) -> AnySequence<URL> {
        return AnySequence { () in
            return DirectoryOrFileIterator(
                fm: self,
                url: url,
                keys: keys,
                options: options,
                stack: [url]
            )
        }
    }

}
