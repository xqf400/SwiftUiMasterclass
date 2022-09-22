//
//  InfoView.swift
//  Slots
//
//  Created by Fabian Kuschke on 21.09.22.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("activateSound") var activateSound = false
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()

            Spacer()
            
            Form{
                Section(header: Text("Sound Settings")) {
                    Toggle(isOn: $activateSound) {
                        Text("Activate Sound")
                    }
                }
                Section(header: Text("About the application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slotmachine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Fabian Kuschke")
                    FormRowView(firstItem: "Designer", secondItem: "Kuschke")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website", secondItem: "fabiankuschke.de")
                    FormRowView(firstItem: "Copyright", secondItem: "Fabi Kuschke")
                    FormRowView(firstItem: "Version", secondItem: "1.0")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                audioPlayer?.stop()
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark.circle")
            }
                .padding(.top, 30)
                .padding(.trailing, 20)
                .accentColor(.secondary)
            , alignment: .topTrailing
        )
        .onAppear {
            playSound(sound: "background-music", type: "mp3")
        }
    }
}



struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack{
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
