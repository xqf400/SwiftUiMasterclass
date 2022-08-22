//
//  CenterModifier.swift
//  Africa
//
//  Created by Fabian Kuschke on 22.08.22.
//

import SwiftUI

struct CenterModifier: ViewModifier{
    func body(content: Content) -> some View{
        HStack{
            Spacer()
            content
            Spacer()
        }
    }
}
