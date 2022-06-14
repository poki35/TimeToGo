//
//  GooglePlacesManager.swift
//  TimeToGo
//
//  Created by Кирилл Пономаренко on 13.06.2022.
//

//import Foundation
//import GooglePlaces
//import GoogleMapsBase
//
//struct Place {
//    let name: String
//    let identifier: String
//}
//
//final class GooglePlacesManager {
//    static let shared = GooglePlacesManager()
//
//    private let client = GMSPlacesClient.shared()
//
//    private init() {}
//
//    enum PlacesError: Error {
//        case failedToFind
//    }
//
//    public func setUp() {
//        GMSPlacesClient.provideAPIKey("AIzaSyC8g0NDN16iq7Ayu_jfmNzgqjRTmz3dZYE")
//    }
//
//    public func findPlaces(query: String, completion: @escaping (Result<[Place], Error>) -> Void )
//    {
//        let filter  = GMSAutocompleteFilter()
//        client.findAutocompletePredictions(
//            fromQuery: query,
//            filter: filter,
//            sessionToken: nil) {
//            results, error in
//
//        guard let results = results, error == nil else {
//                completion(.failure(PlacesError.failedToFind))
//              return
//
//            }
//
//            let places: [Place] = results.compactMap({
//                Place(name: $0.attributedFullText.string,
//                      identifier: $0.placeID)
//            })
//
////                completion.success(places))
//
//            }
//        }
//}
//
//
//
