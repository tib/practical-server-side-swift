import Foundation

extension DateFormatter {

    static var year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        return formatter
    }()
}
