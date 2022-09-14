//
//  ContentView.swift
//  Honeymoon
//
//  Created by Fabian Kuschke on 07.09.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HeaderView()
            Spacer()
            CardView(honeymonn: honeymoonData[2])
                .padding()
            Spacer()
            FooterView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
