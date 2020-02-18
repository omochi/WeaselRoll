extension MutableCollection {
    public mutating func transform(_ f: (inout Element) throws -> Void) rethrows {
        var index = startIndex
        while index != endIndex {
            try f(&self[index])
            index = self.index(after: index)
        }
    }
}
