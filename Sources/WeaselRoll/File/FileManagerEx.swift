import Foundation

extension FileManager {
    public var permanentDirectory: URL {
        urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    
    public var documentDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    public func fileExists(at file: URL) -> Bool {
        fileExists(atPath: file.path)
    }
    
    public func fileExists(at file: URL, isDirectory: inout Bool) -> Bool
    {
        var isDir: ObjCBool = false
        let ret = fileExists(atPath: file.path, isDirectory: &isDir)
        isDirectory = isDir.boolValue
        return ret
    }

    public func directoryExists(at file: URL) -> Bool {
        var isDir = false
        return fileExists(at: file, isDirectory: &isDir) && isDir
    }

    public func createFile(at file: URL, contents: Data?, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        createFile(atPath: file.path, contents: contents, attributes: attributes)
    }

    public func createDirectory(at directory: URL) throws {
        try createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
    }

    public func contentsOfDirectory(at directory: URL) throws -> [URL] {
        try contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
    }

    public func directoryOrFileEnumerator(
        at url: URL,
        includingPropertiesForKeys keys: [URLResourceKey]? = nil,
        options mask: FileManager.DirectoryEnumerationOptions = [],
        errorHandler handler: ((URL, Error) -> Bool)? = nil
    ) -> AnySequence<URL> {
        var isDir = false

        guard fileExists(at: url, isDirectory: &isDir) else {
            return AnySequence([])
        }

        if isDir {
            return AnySequence { () -> AnyIterator<URL> in
                guard let enumerator = self.enumerator(
                    at: url,
                    includingPropertiesForKeys: keys,
                    options: mask,
                    errorHandler: handler
                ) else {
                    return AnyIterator { nil }
                }

                return AnyIterator {
                    enumerator.nextObject() as? URL
                }
            }
        } else {
            return AnySequence([url])
        }
    }

    public var currentDirectory: URL {
        URL(fileURLWithPath: currentDirectoryPath)
    }

    public func changeCurrentDirectory(_ dir: URL) throws {
        guard changeCurrentDirectoryPath(dir.path) else {
            throw MessageError("failed to change current directory: \(dir.path)")
        }
    }

    public func withCurrentDirectory<R>(_ dir: URL, _ f: () throws -> R) throws -> R {
        let old = currentDirectory
        let result: R
        do {
            result = try f()
        } catch {
            _ = try? changeCurrentDirectory(old)
            throw error
        }
        try changeCurrentDirectory(old)
        return result
    }
}
