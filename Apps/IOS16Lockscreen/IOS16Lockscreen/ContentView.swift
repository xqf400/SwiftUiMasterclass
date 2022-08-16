//
//  ContentView.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locksreenModel: LockscreenModel = .init()
    var body: some View {
        Home()
            .environmentObject(locksreenModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
