final class HookStorage {

    var pointers: [HookFunctionPointer<HookFunction>]
    var asyncPointers: [HookFunctionPointer<AsyncHookFunction>]

    init() {
        self.pointers = []
        self.asyncPointers = []
    }
}
