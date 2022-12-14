//
//  Home.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI
import PhotosUI

struct Home: View {
    
    @EnvironmentObject var lockscreenModel: LockscreenModel
    
    var body: some View {
        VStack{
            if let compressedImage = lockscreenModel.compressedImage {
                // Later

                GeometryReader{ proxy in
                    let size = proxy.size
                    Image(uiImage: compressedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    //IF we applay scale to whole view then the time view will be streching, thats why we added gesture to root view and appliny scaling only for the image
                    .scaleEffect(lockscreenModel.scale)
                    .overlay {
                        if let detectedPerson = lockscreenModel.detectedPerson{
                            TimeView()
                                .environmentObject(lockscreenModel)
                            //MARK: Placing over the normal image
                            Image(uiImage: detectedPerson)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(lockscreenModel.scale)
                            

                        }

                    }
                }
            }else{
                // MARK: Image Picker

                    PhotosPicker(selection: $lockscreenModel.pickedItem, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared()) {
                        VStack(spacing: 10){
                            Image(systemName: "plus.viewfinder")
                                .font(.largeTitle)
                            Text("Add Image")
                        }
                        .foregroundColor(.primary)
                    }
            }
        }
        .ignoresSafeArea()
        //MARK: Cacnel Button
        .overlay(alignment: .topLeading){
            Button("Cancel"){
                withAnimation(.easeOut){
                    lockscreenModel.compressedImage = nil
                    lockscreenModel.detectedPerson = nil
                }
                lockscreenModel.scale = 1
                lockscreenModel.lastScale = 0
                lockscreenModel.placeTextAbove = false
            }
            .font(.caption)
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background{
                Capsule()
                    .fill(.ultraThinMaterial)
            }
            .padding()
            .padding(.top, 45)
            .opacity(lockscreenModel.compressedImage == nil ? 0:1)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK: Time View

struct TimeView: View {
    @EnvironmentObject var lockscreenModel: LockscreenModel
    var body: some View {
        HStack(spacing: 6){
            Text(Date.now.convertToString(.hour))
                .font(.system(size:95))
                .fontWeight(.semibold)
            
            //MARK: Dots
            
            VStack(spacing: 10) {
                Circle()
                    .fill(.white)
                    .frame(width: 15, height: 15)
                Circle()
                    .fill(.white)
                    .frame(width: 15, height: 15)
                
                //MARK: Logic for putting time behing the person
                //we use this second dot as a color Rectifier so we will simply check the view this point to be white. if it changes to anyother color then we're putting time view aboce the person. when will this color change eventually when youre scaling the image. the image will goes over it. Thus the white will be disabled
                    .overlay {
                        GeometryReader{ proxy in
                            let rect = proxy.frame(in: .global)
                            Color.clear
                                .preference(key: RectKey.self, value: rect)
                            onPreferenceChange (RectKey.self) { value in
                                lockscreenModel.textRect = value
                            }
                        }
                    }
            }
            
            Text(Date.now.convertToString(.minute))
                .font(.system(size:95))
                .fontWeight(.semibold)
            
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 100)
    }
}

enum DateFormat: String {
    case hour = "HH"
    case minute = "mm"
    case seconds = "ss"
}

extension Date{
    func convertToString(_ format: DateFormat)-> String{
        let formater = DateFormatter()
        formater.dateFormat = format.rawValue
        return formater.string(from: self)
    }
}


//MARK: Rect Prefernece Key

struct RectKey: PreferenceKey{
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
