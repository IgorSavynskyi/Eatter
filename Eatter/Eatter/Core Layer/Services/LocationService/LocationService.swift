import Foundation
import CoreLocation

enum PostalCodeResult {
    case success(String)
    case failure(LocationError)
}

enum LocationError: Error {
    case commonError(String)
    case accessDenied
}

class LocationService: NSObject {
    typealias PostalCodeCompletion = (PostalCodeResult) -> ()

    // MARK: - Props
    static let shared = LocationService()
    
    // MARK: - Private Props
    private let locationManager = CLLocationManager()
    private var postalRequestCallbacks: [PostalCodeCompletion] = []

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    // MARK: - API
    func getUserPostalCode(completion: @escaping PostalCodeCompletion) {
        if LocationPermission.shared.shouldRequestAuthorization {
            LocationPermission.shared.requestAuthorization { (status) in
                switch status {
                case .notDetermined, .restricted, .denied:
                    completion(.failure(.accessDenied))
                case .authorizedAlways, .authorizedWhenInUse:
                    self.postalRequestCallbacks.append(completion)
                }
            }
        } else if let lastLocation = locationManager.location {
            getPostalCode(for: lastLocation, completion: completion)
        } else {
            completion(.failure(.accessDenied))
        }
    }
    
    // MARK: - Private API
    private func getPostalCode(for location: CLLocation, completion: @escaping PostalCodeCompletion) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if let error = error {
                completion(.failure(.commonError(error.localizedDescription)))
            } else if let postalCode = placemarks?.first?.postalCode  {
                completion(.success(postalCode))
            } else {
                completion(.failure(.commonError("Problem with the data received from geocoder")))
            }
        })
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = manager.location {
            postalRequestCallbacks.forEach { getPostalCode(for: lastLocation, completion: $0) }
            postalRequestCallbacks.removeAll()
        } else {
            postalRequestCallbacks.forEach { $0(.failure(.commonError("Failed to get location")))}
            postalRequestCallbacks.removeAll()
        }
    }

}
