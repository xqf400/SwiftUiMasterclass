//
//  GuideView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 14.09.22.
//

import SwiftUI

struct GuideView: View {
    
    //MARK: Properties
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                Spacer(minLength: 10)
                Text("Get started")
                    .fontWeight(.black)
                    .foregroundColor(.blue)
                    .font(.largeTitle)
                Text("Discover and pick the perfect destination")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                VStack(alignment: .leading, spacing: 25) {
                    GuideComponent(title: "Like", subtitle: "Swipe right", description: "Do you like this destination? Touch the screen and swipe right. It will be saved to your favourites", icon: "heart.circle")
                    GuideComponent(title: "Dismiss", subtitle: "Swipe left", description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it", icon: "xmark.circle")
                    GuideComponent(title: "Book", subtitle: "Tap the Button", description: "Our selection ofresorts is the perfect setting for you to embark your new life together", icon: "checkmark.square")
                }
                Spacer(minLength: 10)
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Continue".uppercased())
                        .padding()
                        .font(.headline)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(
                            Capsule().fill(.yellow)
                        )
                        .foregroundColor(.white)
                })
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
