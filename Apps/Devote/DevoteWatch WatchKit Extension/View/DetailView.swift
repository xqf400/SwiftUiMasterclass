//
//  DetailView.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isCreditsPresented: Bool = false
    
    @State private var isSettingsPresented: Bool = false

    
    var body: some View {
        VStack(alignment: .center, spacing: 3){
            //Header
            HeaderView(title: "")
            //Content
            Spacer()
            ScrollView(.vertical){
                Text(note.task)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            //Footer
            HStack(alignment: .center){
                Image(systemName: "gear")
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented) {
                        SettingsView()
                    }
                Spacer()
                Text("\(index + 1) / \(count)")
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented) {
                        CreditsView()
                    }
            }
            .foregroundColor(.secondary)
        }//Vstack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let note = Note(id: UUID(), task: "tasksf", timestamp: Date(), completion: false)

    static var previews: some View {
        DetailView(note: note, count: 5, index: 1)
    }
}
