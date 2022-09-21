//
//  ContentView.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//https://www.youtube.com/watch?v=xd-wqwO0BrM

import SwiftUI

struct ContentView: View {
    @StateObject var lockscreenModel: LockscreenModel = .init()
    var body: some View {
        Home()
        //MARK: Adding Scaling
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({ value in
                        lockscreenModel.scale = value * lockscreenModel.lastScale
                    }).onEnded({ _ in
                        if lockscreenModel.scale < 1 {
                            withAnimation(.easeOut(duration: 0.15)){
                                lockscreenModel.scale = 1
                            }
                        }
                        //MARK: Excluding the main scale
                        lockscreenModel.lastScale = lockscreenModel.scale - 1
                    })
                )
            .environmentObject(lockscreenModel)
        //MARK: Test Show Case
            .overlay{
                //Thus we get correct position
                /*
                Circle()
                    .fill(.red)
                    .frame(width: 15, height: 15)
                    .position(x: lockscreenModel.textRect.midX, y: lockscreenModel.textRect.midY)
                    .ignoresSafeArea()*/
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
