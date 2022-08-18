//
//  VideoModel.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import Foundation

struct Video: Codable, Identifiable{
    let id: String
    let name: String
    let headline: String
    
    //Computed Property
    var thumbnail: String {
        "video-\(id)"
    }
}
