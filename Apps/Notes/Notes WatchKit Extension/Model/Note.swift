//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Fabian Kuschke on 06.09.22.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
