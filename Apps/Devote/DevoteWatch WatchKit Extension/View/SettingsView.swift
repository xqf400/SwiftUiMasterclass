//
//  SettingsView.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    
    //MARK: Function
    func update(){
        lineCount = Int(value)
    }
    
    var body: some View {
        VStack(spacing: 8){
            //Header
            HeaderView(title: "Settings")
            //Actual line count
            Text("Lines \(lineCount)")
                .fontWeight(.bold)
            
            //Slider
            Slider(value: Binding(get: {
                self.value
            }, set: { newValue in
                self.value = newValue
                self.update()
            }), in: 1...4, step: 1)
                .accentColor(.accentColor)
        }//Vstack
        .onAppear {
            value = Float(lineCount)
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
