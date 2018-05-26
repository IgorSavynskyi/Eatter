import Foundation
import CoreLocation

class LocationPermission: NSObject {
    typealias AuthorizationCompletion = (CLAuthorizationStatus) -> ()
    
    // MARK: - Props
    static let shared = LocationPermission()
    var shouldRequestAuthorization: Bool {
        return CLLocationManager.authorizationStatus() == .notDetermined
    }
    
    // MARK: - Private Props
    private var authorizationCallbacks: [AuthorizationCompletion] = []
    private let locationManager = CLLocationManager()
    private override init() {
        super.init()
        locationManager.delegate = self
    }

    // MARK: - API
    func requestAuthorizationIfNeeded(callback: @escaping AuthorizationCompletion) {
        let currentAuthLevel = CLLocationManager.authorizationStatus()
        
        if currentAuthLevel == .notDetermined {
            requestAuthorization(callback: callback)
        } else {
            callback(currentAuthLevel)
        }
    }
    
    func requestAuthorization(callback: @escaping AuthorizationCompletion) {
        authorizationCallbacks.append(callback)
        locationManager.requestWhenInUseAuthorization()
    }
}


extension LocationPermission: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationCallbacks.forEach { $0(status) }
        authorizationCallbacks.removeAll()
    }
}
