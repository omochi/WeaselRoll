import Foundation

extension FileManager {
    private struct DOFIterator: IteratorProtocol {
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

                guard let files = try? fm.relativeContentsOfDirectory(
                        at: head,
                        includingPropertiesForKeys: keys,
                        options: options
                ) else {
                    continue
                }

                stack += files
            }
        }
    }

    public func directoryOrFileEnumerator(
        at url: URL,
        includingPropertiesForKeys keys: [URLResourceKey]? = nil,
        options: DirectoryEnumerationOptions = []
    ) -> AnySequence<URL> {
        return AnySequence { () in
            return DOFIterator(
                fm: self,
                url: url,
                keys: keys,
                options: options,
                stack: [url]
            )
        }
    }

}
