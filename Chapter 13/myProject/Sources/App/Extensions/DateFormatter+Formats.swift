import Foundation

extension DateFormatter {

    static var custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y.MM.dd. HH:mm:ss"
        return formatter
    }()
}
