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
    
    @State private var textTitle: String = "Share."
    
    
    //MARK: - Body
    var body: some View {
        //        VStack(spacing: 20){
        //        Text("Onboarding")
        //            .font(.largeTitle)
        //
        //            Button(action: {
        //                isOnoardingViewActive = false
        //            }){
        //                Text("Start")
        //            }
        //
        //        }//:VSTACK
        
        
        
        //}
        
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - HEADER
                
                Spacer()
                
                //command option left arrowr einklappen
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                It's not how much we give but
                how much love we put into giving.
                """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                } //: HEADER
                
                // MARK: - CENTER
                ZStack {
                    ZStack{
                        Circle()
                            .stroke(.white.opacity(0.2),lineWidth: 40)
                            .frame(width: 260, height: 260, alignment: .center)
                        Circle()
                            .stroke(.white.opacity(0.2), lineWidth: 80)
                            .frame(width: 260, height: 260, alignment: .center)
                    }
                    Image("character-1")
                      .resizable()
                      .scaledToFit()
                }//: CENTER
                
            } //: VSTACK
        } //: ZSTACK
        
        
        
        
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
