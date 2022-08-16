//
//  CustomColorFinder.swift
//  IOS16Lockscreen
//
//  Created by Fabian Kuschke on 16.08.22.
//

import SwiftUI
//MARK: This view will return color based on the xy coordinates
struct CustomColorFinderView<Content: View>: UIViewRepresentable {

    @EnvironmentObject var lockscreenModel: LockscreenModel
    var content: Content
    var onLoad: (UIView)->()
    //19:40
    init(@ViewBuilder content: @escaping ()->Content, onLoad: @escaping(UIView)-> ()) {
        self.content = content()
        self.onLoad = onLoad
    }
    
    func makeUIView(context: Context) -> UIView {
        let size = UIApplication.shared.screenSize()
        let host = UIHostingController(rootView: content
            .frame(width: size.width, height: size.height)
            .environmentObject(lockscreenModel)
        )
        host.view.frame = CGRect(origin: .zero, size: size)
        return host.view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // Simply getting the uiview as reference so that wen can checl color of the view
        DispatchQueue.main.async {
            onLoad(uiView)
        }
    }
}

//struct CustomColorFinder_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomColorFinder()
//    }
//}
