//
//  InfoView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 14.09.22.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators: false){
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                Spacer(minLength: 10)
                
                Text("App Info")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                AppInfoView()
                
                Text("Credits")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                CreditsView()
                Spacer(minLength: 10)
                
                Button {
                    
                } label: {
                    Text("Continue".uppercased())
                        .foregroundColor(.black)
                        .modifier(ButtonModifier())
                }

            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal,25)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

struct AppInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RowAppInfoView(itemOne: "Application", itemTwo: "Honeymoon")
            RowAppInfoView(itemOne: "Compatibility", itemTwo: "iPhone and iPad")
            RowAppInfoView(itemOne: "Developer", itemTwo: "Fabian Kuschke")
            RowAppInfoView(itemOne: "Designer", itemTwo: "Maker")
            RowAppInfoView(itemOne: "Website", itemTwo: "https://fabiankuschke.de")
            RowAppInfoView(itemOne: "Version", itemTwo: "1.0")
        }
    }
}

struct RowAppInfoView: View {
    
    //MARK: Properties
    var itemOne: String
    var itemTwo: String
    
    var body: some View {
        VStack {
            HStack{
                Text(itemOne)
                    .foregroundColor(.gray)
                Spacer()
                Text(itemTwo)
            }
            Divider()
        }
    }
}

struct CreditsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text("Photos")
                    .foregroundColor(.gray)
                Spacer()
                Text("Unsplash")
            }
            Divider()
            Text("Photographers").foregroundColor(.gray)
            Text("Shifaaz Shamoon (Maldives), Grillot Edouard (France), Evan Wise (Greece), Christoph Schulz (United Arab Emirates), Andrew Coelho (USA), Damiano Baschiera (Italy), Daniel Olah (Hungary), Andrzej Rusinowski (Poland), Lucas Miguel (Slovenia), Florencia Potter (Spain), Ian Simmonds (USA), Ian Keefe (Canada), Denys Nevozhai (Thailand), David Köhler (Italy), Andre Benz (USA), Alexandre Chambon (South Korea), Roberto Nickson (Mexico), Ajit Paul Abraham (UK), Jeremy Bishop (USA), Davi Costa (Brazil), Liam Pozz (Australia)")
                .multilineTextAlignment(.leading)
                .font(.footnote)
        }
    }
}
