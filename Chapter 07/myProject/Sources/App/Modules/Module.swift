import Vapor

protocol Module {
    
    func boot(_ app: Application) throws
}

extension Module {
    func boot(_ app: Application) throws {}
}
