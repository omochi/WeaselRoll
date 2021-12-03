import Foundation
import WeaselRoll

extension FileManager {
    private var ex: FileManagerEx {
        FileManagerEx(manager: self)
    }

    public var permanentDirectory: URL {
        ex.permanentDirectory
    }
    
    public var documentDirectory: URL {
        ex.documentDirectory
    }

    public func fileExists(at file: URL) -> Bool {
        ex.fileExists(at: file)
    }
    
    public func fileExists(at file: URL, isDirectory: inout Bool) -> Bool {
        ex.fileExists(at: file, isDirectory: &isDirectory)
    }

    public func directoryExists(at file: URL) -> Bool {
        ex.directoryExists(at: file)
    }

    public func createFile(at file: URL, contents: Data?, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        ex.createFile(
            at: file,
            contents: contents,
            attributes: attributes
        )
    }

    public func createDirectory(
        at directory: URL,
        withIntermediateDirectories createIntermediates: Bool = true,
        attributes: [FileAttributeKey : Any]? = nil
    ) throws {
        try ex.createDirectory(
            at: directory,
            withIntermediateDirectories: createIntermediates,
            attributes: attributes
        )
    }

    public func relativeContentsOfDirectory(
        at directory: URL,
        includingPropertiesForKeys keys: [URLResourceKey]? = nil,
        options mask: FileManager.DirectoryEnumerationOptions = []
    ) throws -> [URL] {
        try ex.relativeContentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: keys,
            options: mask
        )
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
