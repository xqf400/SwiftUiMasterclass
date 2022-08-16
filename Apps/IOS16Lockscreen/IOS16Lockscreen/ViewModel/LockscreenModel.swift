//
//  LockscreenModel.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI
import PhotosUI
import SDWebImage

class LockscreenModel: ObservableObject {
    //Image picker
    @Published var pickedItem: PhotosPickerItem?{
        didSet{
            //MARK: Extracting Image
            extractImage()
        }
    }
    @Published var compressedImage: UIImage?
    
    
    func extractImage(){
        if let pickedItem{
            Task{
                guard let imageData = try? await pickedItem.loadTransferable(type: Data.self) else {return}
                //MARK: Resziz image to phone size * 2
                let size = await UIApplication.shared.screenSize()
                let image = UIImage(data: imageData)?.sd_resizedImage(with: CGSize(width: size.width * 2, height: size.height * 2), scaleMode: .aspectFill)
                await MainActor.run(body: {
                    self.compressedImage = image
                })
            }
        }
    }
    
}

extension UIApplication {
    func screenSize() -> CGSize {
        guard let window = connectedScenes.first as? UIWindowScene else {return .zero}
        return window.screen.bounds.size
    }
}
