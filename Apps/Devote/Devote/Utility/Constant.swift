//
//  Constant.swift
//  Devote
//
//  Created by Fabian Kuschke on 02.09.22.
//

import SwiftUI

//MARK: Formatter

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

func formatIt(date: Date)->String{
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    formatter.dateFormat = "YYYY.MM.dd HH:mm"
    let formattedString : String = formatter.string(for: date)!
    return formattedString
}


//MARK: UI

var backgroundGradient: LinearGradient{
    return LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//MARK: UX

let feedback = UINotificationFeedbackGenerator()
