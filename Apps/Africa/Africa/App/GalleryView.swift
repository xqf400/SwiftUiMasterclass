//
//  GalleryView.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import SwiftUI

struct GalleryView: View {
    
    let animals: [Animal] = Bundle.main.decocde("animals.json")
    
    let gridLayout: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(animals) { item in
                    Text("Gallery")
                }
            }//Grid
        }//Scroll
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
        .ignoresSafeArea(.all)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
