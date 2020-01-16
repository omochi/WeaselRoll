import Foundation

extension FileManager {
    public var documentDirectory: URL {
        return urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    public var temporaryDirectory: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    public func fileExists(at file: URL) -> Bool {
        return fileExists(atPath: file.path)
    }
    
    public func fileExists(at file: URL, isDirectory: inout Bool) -> Bool
    {
        var isDir: ObjCBool = false
        let ret = fileExists(atPath: file.path, isDirectory: &isDir)
        isDirectory = isDir.boolValue
        return ret
    }
}
