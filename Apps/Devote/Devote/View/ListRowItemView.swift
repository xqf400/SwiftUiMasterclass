//
//  ListRowItemView.swift
//  Devote
//
//  Created by Fabian Kuschke on 05.09.22.
//

import SwiftUI
import WidgetKit

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.blue : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
        }//Toggle
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
    }
}

