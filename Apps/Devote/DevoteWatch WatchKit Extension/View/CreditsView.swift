//
//  CreditsView.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import SwiftUI

struct CreditsView: View {
    
    @State private var randomNumber : Int = Int.random(in: 1..<4) //1-3
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    
    
    var body: some View {
        VStack(spacing: 3){
            //Image
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            //Header
            HeaderView(title: "Credits")
            //Content
            Text("Fabian Kuschke")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .fontWeight(.light)
                .foregroundColor(.secondary)
        }//Vstack
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
