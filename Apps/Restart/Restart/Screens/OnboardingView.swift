//
//  OnboardingView.swift
//  Restart
//
//  Created by Fabian Kuschke on 12.08.22.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Property
    
    @AppStorage("onboarding") var isOnoardingViewActive: Bool = true //User defaults
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 20){
        Text("Onboarding")
            .font(.largeTitle)
            
            Button(action: {
                isOnoardingViewActive = false
            }){
                Text("Start")
            }

        }//:VSTACK
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
