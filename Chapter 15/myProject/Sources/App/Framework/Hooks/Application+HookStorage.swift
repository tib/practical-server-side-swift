import Vapor

extension Application {

    private struct HookStorageKey: StorageKey {
        typealias Value = HookStorage
    }

    var hooks: HookStorage {
        get {
            if let existing = storage[HookStorageKey.self] {
                return existing
            }
            let new = HookStorage()
            storage[HookStorageKey.self] = new
            return new
        }
        set {
            storage[HookStorageKey.self] = newValue
        }
    }
}
