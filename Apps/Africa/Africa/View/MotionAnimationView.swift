//
//  MotionAnimationView.swift
//  Africa
//
//  Created by Fabian Kuschke on 19.08.22.
//

import SwiftUI

struct MotionAnimationView: View {
    @State private var randomCircle = Int.random(in: 12...16)
    @State private var isAnimating: Bool = false
    
    //MARK: function
    
    //1. Random Coordinate
    func randomCoordinate(max: CGFloat) -> CGFloat{
        return CGFloat.random(in: 0...max)
    }
    
    
    //2. Random size
    func randomSize() -> CGFloat {
        return CGFloat(Int.random(in: 10...300))
    }
    //3. Random scale
    func randomScale() -> CGFloat{
        return CGFloat(Double.random(in: 0.1...2.0))
    }
    //4. Random speed
    func randomSpeed() -> Double {
        return Double.random(in: 0.025...1.0)
    }
    //5. Random delay
    func randomDelay() -> Double{
        return Double.random(in: 0...2)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0...randomCircle, id: \.self) { item in
                    Circle()
                        .foregroundColor(.gray)
                        .opacity(0.15)
                        .frame(width: randomSize(), height: randomSize(), alignment: .center)
                        .scaleEffect(isAnimating ? randomScale() : 1)
                        .position(
                            x: randomCoordinate(max:geometry.size.width),
                            y: randomCoordinate(max:geometry.size.height)
                        )
//                        .animation(
//                            Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
//                                .repeatForever()
//                                .speed(randomSpeed())
//                                .delay(randomDelay())
//                        )
                        .animation(
                            Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5)
                                .repeatForever()
                                .speed(randomSpeed())
                                .delay(randomDelay())
                            , value: isAnimating)
                    
                        .onAppear {
                            isAnimating = true
                        }
                }//Loop
//                Text("Width: \(Int(geometry.size.width)) Height: \(Int(geometry.size.height))")
            }//Zstack
            .drawingGroup()//Better drawing
        }// geometry
    }
}

struct MotionAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        MotionAnimationView()
    }
}
