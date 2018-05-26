import Foundation
import UIKit

class AppService {
    // MARK: - Props
    static let shared = AppService()
    var showNetworkActivity = false { didSet { showNetworkActivityIndicator(showNetworkActivity) }}
    private init() {}

    // MARK: - Private API
    private func showNetworkActivityIndicator(_ value: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = value
        }
    }
    
}

