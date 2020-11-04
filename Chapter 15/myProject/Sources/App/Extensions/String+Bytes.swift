import Foundation

extension String {
    var bytes: [UInt8] { .init(self.utf8) }
}
