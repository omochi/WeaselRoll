import Foundation

extension FileManager {
    public var permanentDirectory: URL {
        urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    }
    
    public var documentDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    public var temporaryDirectory: URL {
        URL(fileURLWithPath: NSTemporaryDirectory())
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

    public func createFile(at file: URL, contents: Data?, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        createFile(atPath: file.path, contents: contents, attributes: attributes)
    }
}
