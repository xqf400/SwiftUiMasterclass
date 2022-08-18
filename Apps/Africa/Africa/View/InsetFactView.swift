//
//  InsetFactView.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import SwiftUI

struct InsetFactView: View {
    
    let animal: Animal
    var body: some View {
        
        GroupBox {
            TabView{
                ForEach(animal.fact, id: \.self){ item in
                    Text(item)
                }
            }//Tab
            .tabViewStyle(PageTabViewStyle())
            .frame(minHeight: 148, idealHeight: 168, maxHeight: 180)
        }//Box
    }
}

struct InsetFactView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decocde("animals.json")
    
    
    static var previews: some View {
        InsetFactView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
