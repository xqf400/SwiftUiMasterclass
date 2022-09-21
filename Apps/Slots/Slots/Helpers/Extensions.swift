//
//  Extensions.swift
//  Slots
//
//  Created by Fabian Kuschke on 21.09.22.
//

import SwiftUI

extension Text{
    func scoreLabelStyle() -> Text{
        self
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    func scoreNumberSytle()-> Text{
        self
            .foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
