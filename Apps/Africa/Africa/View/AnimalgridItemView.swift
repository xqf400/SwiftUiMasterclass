//
//  AnimalgridItemView.swift
//  Africa
//
//  Created by Fabian Kuschke on 22.08.22.
//

import SwiftUI

struct AnimalgridItemView: View {
    
    let animal: Animal
    
    var body: some View {
        Image(animal.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct AnimalgridItemView_Previews: PreviewProvider {
    static let animals: [Animal] = Bundle.main.decocde("animals.json")
    static var previews: some View {
        AnimalgridItemView(animal: animals[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
