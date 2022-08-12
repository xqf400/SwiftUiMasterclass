//
//  ContentView.swift
//  Restart
//
//  Created by Fabian Kuschke on 12.08.22.
//

import SwiftUI

struct ContentView: View {
    
    //Userdefauts store value
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack{
            if isOnboardingViewActive {
                OnboardingView()
            }else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
