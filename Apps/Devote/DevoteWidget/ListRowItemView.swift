//
//  ListRowItemView.swift
//  Devote
//
//  Created by Fabian Kuschke on 13.09.22.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.medium)
                .foregroundColor(item.completion ? Color.yellow : Color.primary)
                .padding(.vertical, 8)
                //.animation(.default)
        }//Toggle
        //.toggleStyle(CheckboxStyle())
        /*
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
                print("saved")
            }
        }*/
    }
}
