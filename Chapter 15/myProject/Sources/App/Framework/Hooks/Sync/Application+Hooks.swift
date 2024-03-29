import Vapor

extension Application {

    func invoke<ReturnType>(
        _ name: String,
        args: HookArguments = [:]
    ) -> ReturnType? {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return hooks.invoke(name, args: ctxArgs)
    }

    func invokeAll<ReturnType>(
        _ name: String,
        args: HookArguments = [:]
    ) -> [ReturnType] {
        let ctxArgs = args.merging(["app": self]) { (_, new) in new }
        return hooks.invokeAll(name, args: ctxArgs)
    }
}
