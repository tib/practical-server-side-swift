import Vapor

public extension EventLoop {

    func mergeTrueFutures(_ futures: [EventLoopFuture<Bool>]) -> EventLoopFuture<Bool> {
        let initial: EventLoopFuture<Bool> = future(true)
        return futures.reduce(initial) { [unowned self] f1, f2 -> EventLoopFuture<Bool> in
            f1.flatMap { [unowned self] in $0 ? f2 : future(false) }
        }
    }
}
