import Foundation

extension String {
    var bytes: [UInt8] {
        return .init(self.utf8)
    }
}
