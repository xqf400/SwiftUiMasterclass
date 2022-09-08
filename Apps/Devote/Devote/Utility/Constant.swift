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



//MARK: Extensions and other things
// This is taken from the Release Notes, with a typo correction, marked below
struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)
    
    let base: Base
    
    var startIndex: Index { base.startIndex }
    
    // corrected typo: base.endIndex, instead of base.startIndex
    var endIndex: Index { base.endIndex }
    
    func index(after i: Index) -> Index {
        base.index(after: i)
    }
    
    func index(before i: Index) -> Index {
        base.index(before: i)
    }
    
    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }
    
    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
