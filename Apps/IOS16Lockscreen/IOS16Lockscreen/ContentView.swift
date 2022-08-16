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
        //MARK: Adding Scaling
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({ value in
                        locksreenModel.scale = value * locksreenModel.lastScale
                    }).onEnded({ _ in
                        if locksreenModel.scale < 1 {
                            withAnimation(.easeOut(duration: 0.15)){
                                locksreenModel.scale = 1
                            }
                        }
                        //MARK: Excluding the main scale
                        locksreenModel.lastScale = locksreenModel.scale - 1
                    })
                )
            .environmentObject(locksreenModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
