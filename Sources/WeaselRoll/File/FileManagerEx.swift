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
}
