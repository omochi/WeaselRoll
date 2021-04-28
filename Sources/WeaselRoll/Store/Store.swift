public struct Store<T>: StoreProtocol {
    private let _load: () throws -> T
    private let _store: (T) throws -> Void

    public init<X: StoreProtocol>(
        _ x: X
    )
    where X.Value == T
    {
        self.init(
            load: { try x.load() },
            store: { try x.store($0) }
        )
    }

    public init(
        load: @escaping () throws -> T,
        store: @escaping (T) throws -> Void
    ) {
        self._load = load
        self._store = store
    }

    public func load() throws -> T { try _load() }
    public func store(_ value: T) throws { try _store(value) }
}
