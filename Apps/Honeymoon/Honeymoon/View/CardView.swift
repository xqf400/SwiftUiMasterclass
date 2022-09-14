//
//  CardView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 14.09.22.
//

import SwiftUI

struct CardView: View {
    
    //MARK: Properties
    
    let id = UUID()
    var honeymonn: Destination
    
    var body: some View {
        Image(honeymonn.image)
            .resizable()
            .cornerRadius(24)
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay (
                VStack(alignment: .center, spacing: 12){
                    Text(honeymonn.place.uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 1)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 4)
                        .overlay(
                            Rectangle()
                                .fill(.white)
                                .frame(height:1),
                            alignment: .bottom
                        )
                    Text(honeymonn.country.uppercased())
                        .foregroundColor(.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 85)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(.white)
                        )
                }
                    .frame(minWidth: 280)
                    .padding(.bottom, 50),
                alignment: .bottom
                
            )
        
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(honeymonn: honeymoonData[1])
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
