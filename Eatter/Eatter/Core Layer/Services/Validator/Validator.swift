import Foundation

class Validator {
    // MARK: - API
    static func isValidPostCode(_ candidate: String?) -> Bool {
        guard let candidate = candidate else { return false }
        return candidate.count > 3 && candidate.count < 15
    }
}
