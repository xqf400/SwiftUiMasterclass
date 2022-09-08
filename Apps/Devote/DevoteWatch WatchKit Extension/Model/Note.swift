//
//  Note.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let task: String
    let timestamp: Date
    let completion : Bool
}
