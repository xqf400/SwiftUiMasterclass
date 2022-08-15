//
//  HomeView.swift
//  Restart
//
//  Created by Fabian Kuschke on 12.08.22.
//

import SwiftUI

struct HomeView: View {
    //MARK: - Property
    
    @AppStorage("onboarding") var isOnoardingViewActive: Bool = false //User defaults
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
//            Text("Home")
//                .font(.largeTitle)
            
            //MARK: Header
            
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .blue, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
            }
            
            //MARK: Center
            
            Text("The time taht leads to mastery is dependent to the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: Footer
            
            Spacer()
            
            Button {
                isOnoardingViewActive = true
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            }//Button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)

        }//Vtsack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
