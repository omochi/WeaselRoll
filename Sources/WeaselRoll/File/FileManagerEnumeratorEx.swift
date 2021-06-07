import Foundation

extension FileManager {
    private struct DOFIterator: IteratorProtocol {
        var fm: FileManager
        var url: URL
        var keys: [URLResourceKey]?
        var options: DirectoryEnumerationOptions
        var errorHandler: ((URL, Error) -> Bool)?

        var step = 0
        var enumerator: DirectoryEnumerator? = nil

        mutating func next() -> URL? {
            while true {
                switch step {
                case 0:
                    var isDir = false
                    guard fm.fileExists(at: url, isDirectory: &isDir) else {
                        return nil
                    }
                    if !isDir {
                        step = -1
                        return url
                    }
                    step = 1
                    return url
                case 1:
                    guard let emr = fm.enumerator(
                        at: url,
                        includingPropertiesForKeys: keys,
                        options: options,
                        errorHandler: errorHandler
                    ) else {
                        step = -1
                        return nil
                    }
                    enumerator = emr
                    step = 2
                case 2:
                    guard let obj = enumerator?.nextObject(),
                          let url = obj as? URL else
                    {
                        step = -1
                        return nil
                    }

                    return url
                default:
                    return nil
                }
            }
        }
    }

    public func directoryOrFileEnumerator(
        at url: URL,
        includingPropertiesForKeys keys: [URLResourceKey]? = nil,
        options mask: FileManager.DirectoryEnumerationOptions = [],
        errorHandler handler: ((URL, Error) -> Bool)? = nil
    ) -> AnySequence<URL> {
        return AnySequence { () in
            return DOFIterator(
                fm: self,
                url: url,
                keys: keys,
                options: mask,
                errorHandler: handler
            )
        }
    }

}
