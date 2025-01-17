import UIKit
import CoreLocation

enum LocationFetchingError: Error {
    case error(Error)
    case noErrorMessage
}

class ZipCodeHelper {
    
    // MARK: - Static Methofs
    static func getLatLong(fromZipCodeOrCity searchString: String, completionHandler: @escaping (Result<(lat: Double, long: Double, location: String), LocationFetchingError>) -> Void) {
    
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(searchString) {(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let coordinate = placemark.location?.coordinate, let location = placemark.locality {
                        completionHandler(.success((coordinate.latitude, coordinate.longitude, location)))
                        print(location)
                    } else {
                        let locationError: LocationFetchingError
                        if let error = error {
                            locationError = .error(error)
                        } else {
                            locationError = .noErrorMessage
                        }
                        completionHandler(.failure(locationError))
                    }
                }
            }
        }
    }
    
    // MARK: - Private Initalizers
    private init() {}
}
