//
//  GalleryView.swift
//  Africa
//
//  Created by Fabian Kuschke on 18.08.22.
//

import SwiftUI

struct GalleryView: View {
    
    @State private var selectedAnimal: String = ""
    let animals: [Animal] = Bundle.main.decocde("animals.json")
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    //Mehrere Zeilen markieren Shift control arrow up/down
    //let gridLayout: [GridItem] = [
    //    GridItem(.flexible()),
    //    GridItem(.flexible()),
    //    GridItem(.flexible())
    //]
    
    //Efficient grid definition
    //let gridLayout: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    //Dynamic Grid layout
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn : Double = 3.0
    
    func gridSwitch(){
        gridLayout = Array(repeating: .init(.flexible()), count: Int(gridColumn))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 30) {
                
                //Image
                Image(selectedAnimal)
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 10))
                    .animation(.easeOut)
                
                //Slider
                Slider(value: $gridColumn, in: 1...6, step: 1)
                    .padding(.horizontal)
                    .onChange(of: gridColumn) { newValue in
                        gridSwitch()
                    }
                
                //Grid
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                    ForEach(animals) { item in
                        Image(item.image)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .onTapGesture {
                                selectedAnimal = item.image
                                haptics.impactOccurred()
                            }
                    }//loop
                }//Grid
                .animation(.easeIn)
                .onAppear {
                    selectedAnimal = animals[4].image
                    gridSwitch()
                }
            }//Vstack
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        }//Scroll
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(MotionAnimationView())
        //.ignoresSafeArea(.all)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
