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
    @Published var pickedItem: PhotosPickerItem?{ // ios 16
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
    @Published var view: UIView = .init()
    @Published var placeTextAbove: Bool = false
    @Published var onLoad : Bool = false
    
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
            self.onLoad = true
        }
    }
    
    //MARK: Checking textview coordonates color is still white or not
    func verifyScreenColor(){
        //for more depth effect converting it to midy to miny
        //make sure it is poitin out your text color
        let rgba = view.color(at: CGPoint(x: textRect.midX, y: textRect.minY + 5)) // erhöhen für weniger sichtbarkeit
        print("RGBA: \(rgba)")
        //Note since white color = 1,1,1,1 im directly comparing. if youre using another textcolor  then change here
        withAnimation(.easeInOut) {
            if rgba.0 == 1 && rgba.1 == 1 && rgba.2 == 1 && rgba.3 == 1 {
                placeTextAbove = false
            }else{
                placeTextAbove = true
            }
        }
    }
    
    
}

extension UIView{
    //RGBA
    func color(at point: CGPoint) -> (CGFloat, CGFloat, CGFloat, CGFloat){
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        var pixelData: [UInt8] = [0,0,0,0]
        let contect = CGContext(data: &pixelData, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorspace, bitmapInfo: bitmapInfo.rawValue)
        contect!.translateBy(x: -point.x, y: -point.y)
        
        self.layer.render(in: contect!)
        let red = CGFloat(pixelData[0]) / 255
        let blue = CGFloat(pixelData[1]) / 255
        let green = CGFloat(pixelData[2]) / 255
        let alpha = CGFloat(pixelData[3]) / 255
        
        return (red, green, blue, alpha)
    }
}

extension UIApplication {
    func screenSize() -> CGSize {
        guard let window = connectedScenes.first as? UIWindowScene else {return .zero}
        return window.screen.bounds.size
    }
}
