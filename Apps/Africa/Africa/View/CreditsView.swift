//
//  CreditsView.swift
//  Africa
//
//  Created by Fabian Kuschke on 22.08.22.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Image("compass")
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
            Text("""
    Copyright © Fabian Kuschke
    All right reserved
    🍻
    """)
            .font(.footnote)
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 60)
        }//vstack
        .padding()
        .opacity(0.4)
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
