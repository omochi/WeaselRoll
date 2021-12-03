import Foundation

public struct FileManagerEx {
    public var manager: FileManager

    public init(manager: FileManager) {
        self.manager = manager
    }

    public var permanentDirectory: URL {
        manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }

    public var documentDirectory: URL {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    public func fileExists(at file: URL) -> Bool {
        manager.fileExists(atPath: file.path)
    }

    public func fileExists(at file: URL, isDirectory: inout Bool) -> Bool
    {
        var isDir: ObjCBool = false
        let ret = manager.fileExists(atPath: file.path, isDirectory: &isDir)
        isDirectory = isDir.boolValue
        return ret
    }

    public func directoryExists(at file: URL) -> Bool {
        var isDir = false
        return fileExists(at: file, isDirectory: &isDir) && isDir
    }

    public func createFile(
        at file: URL,
        contents: Data?,
        attributes: [FileAttributeKey: Any]? = nil
    ) -> Bool {
        manager.createFile(
            atPath: file.path,
            contents: contents,
            attributes: attributes
        )
    }

    public func createDirectory(
        at directory: URL,
        withIntermediateDirectories createIntermediates: Bool = true,
        attributes: [FileAttributeKey : Any]? = nil
    ) throws {
        try manager.createDirectory(
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
        return try manager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: keys,
            options: mask
        ).map { (file) in
            directory.appendingPathComponent(file.lastPathComponent)
        }
    }
}
