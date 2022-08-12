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
            Text("Home")
                .font(.largeTitle)
            
            Button {
                isOnoardingViewActive = true
            } label: {
                Text("Restart")
            }

        }//Vtsack
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
