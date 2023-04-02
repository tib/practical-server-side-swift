import Vapor

public extension ByteBuffer {
    
    var data: Data? {
        getData(at: 0, length: readableBytes)
    }
}
