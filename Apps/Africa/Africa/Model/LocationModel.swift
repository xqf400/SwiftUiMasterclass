//
//  LocationModel.swift
//  Africa
//
//  Created by Fabian Kuschke on 19.08.22.
//

import Foundation
import CoreLocation
struct NationalParkLocation: Codable, Identifiable{
    var id : String
    var name: String
    var image: String
    var latitude: Double
    var longitude: Double
    
    //Computed Property
    var location: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
