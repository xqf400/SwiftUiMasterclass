//
//  ContentView.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI

//https://www.youtube.com/watch?v=xd-wqwO0BrM

struct ContentView: View {
    @StateObject var lockscreenModel: LockscreenModel = .init()
    var body: some View {
        CustomColorFinderView(content:  {
            Home()
        }, onLoad: { view in
            lockscreenModel.view = view
        })
        .overlay(alignment: .top, content: {
            TimeView()
                .environmentObject(lockscreenModel)
                .opacity(lockscreenModel.placeTextAbove ? 1 : 0)
        })
        //Since home is edges ignored, we need to ignore it for uikit ranslated view
        .ignoresSafeArea()
        .environmentObject(lockscreenModel)
        //MARK: Adding Scaling
            .gesture(
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({ value in
                        lockscreenModel.scale = value * lockscreenModel.lastScale
                        lockscreenModel.verifyScreenColor()
                    }).onEnded({ _ in
                        if lockscreenModel.scale < 1 {
                            withAnimation(.easeOut(duration: 0.15)){
                                lockscreenModel.scale = 1
                            }
                        }
                        //MARK: Excluding the main scale
                        lockscreenModel.lastScale = lockscreenModel.scale - 1
                        //MARK: After animateion completes
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            lockscreenModel.verifyScreenColor()
                        }
                    })
                )
            .environmentObject(lockscreenModel)
            .onChange(of: lockscreenModel.onLoad) { newValue in
                //what if the image is already above initially
                if newValue{
                    lockscreenModel.verifyScreenColor()
                }
            }
        //MARK: Test Show Case
            //.overlay{
                //Thus we get correct position
                /*
                Circle()
                    .fill(.red)
                    .frame(width: 15, height: 15)
                    .position(x: lockscreenModel.textRect.midX, y: lockscreenModel.textRect.midY)
                    .ignoresSafeArea()*/
            //}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
