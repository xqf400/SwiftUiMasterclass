//
//  ContentView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 07.09.22.
//

import SwiftUI

struct ContentView: View {
    //MARK: Properties
    
    @State var showAlert: Bool = false
    @State var showGuide: Bool = false
    @State var showInfo: Bool = false

    var body: some View {
        VStack {
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
            Spacer()
            CardView(honeymonn: honeymoonData[2])
                .padding()
            Spacer()
            FooterView(showBookingAlert: $showAlert)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishing a lovely and most precius of the times together for the amazing couple"),
                  dismissButton: .default(
                    Text("Happy Honeymoon!")
                  ))
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
