//
//  LockscreenModel.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI
import PhotosUI
import SDWebImage
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

class LockscreenModel: ObservableObject {
    //Image picker
    @Published var pickedItem: PhotosPickerItem?{
        didSet{
            //MARK: Extracting Image
            extractImage()
        }
    }
    @Published var compressedImage: UIImage?
    @Published var detectedPerson: UIImage?
    
    //MARK: Scaleing Properites
    
    @Published var scale: CGFloat = 1
    @Published var lastScale : CGFloat = 0
    
    @Published var textRect: CGRect = .zero
    
    func extractImage(){
        if let pickedItem{
            Task{
                guard let imageData = try? await pickedItem.loadTransferable(type: Data.self) else {
                    print("no image data")
                    return}
                //MARK: Resziz image to phone size * 2
                let size = await UIApplication.shared.screenSize()
                let image = UIImage(data: imageData)?.sd_resizedImage(with: CGSize(width: size.width * 2, height: size.height * 2), scaleMode: .aspectFill)
                await MainActor.run(body: {
                    self.compressedImage = image
                    segmetPersonOnImage()
                })
            }
        }
    }
    
    //MARK: Person Segmentation Using Vision
    func segmetPersonOnImage(){
        guard let image = compressedImage?.cgImage else{
            print("no compressed image")
            return}
        //MARK: Request
        let request = VNGeneratePersonSegmentationRequest()
        //MARK: Set this to true only for Testing in Simulator
        request.usesCPUOnly = true
        
        //MARK: task Handler
        let task = VNImageRequestHandler(cgImage: image)
        do{
            try task.perform([request])
            
            //MARK: Result
            if let result = request.results?.first{
                let buffer = result.pixelBuffer
                maskWithOriginalImage(buffer: buffer)
                print("Buffer: \(buffer)")
            }
        }catch{
            print("Error 1 \(error.localizedDescription)")
        }
    }
    
    //MARK: it will give the mask/outline of the person present in the image
    //we need to mask it with the original image, in order to remove the background
    
    func maskWithOriginalImage(buffer: CVPixelBuffer){
        guard let cgImage = compressedImage?.cgImage else
        {
            print("compressed image")
            return
        }
        let original = CIImage(cgImage: cgImage)
        let mask = CIImage(cvImageBuffer: buffer)
        
        //MARK: Scaling Properties of the masl in order to fit perfectly
        let maskX = original.extent.width / mask.extent.width
        let maskY = original.extent.height / mask.extent.height
        
        let resizedMask = mask.transformed(by: CGAffineTransform(scaleX: maskX, y: maskY))
        
        //MARK: Filter using core image
        let filter = CIFilter.blendWithMask()
        filter.inputImage = original
        filter.maskImage = resizedMask
        
        if let maskedImage = filter.outputImage{
            //MARK: Creating uiimage
            let context = CIContext()
            guard let image = context.createCGImage(maskedImage, from: maskedImage.extent) else {return}
            
            //This is detected Person image
            self.detectedPerson = UIImage(cgImage: image)
        }
    }
}

extension UIApplication {
    func screenSize() -> CGSize {
        guard let window = connectedScenes.first as? UIWindowScene else {return .zero}
        return window.screen.bounds.size
    }
}
