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
                    .frame().frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay {
                        TimeView()
                            .environmentObject(lockscreenModel)
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
                }
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
            }
            
            Text(Date.now.convertToString(.hour))
                .font(.system(size:95))
                .fontWeight(.semibold)
            
        }
    }
}

enum DateFormat: String {
    case hour = "hh"
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
