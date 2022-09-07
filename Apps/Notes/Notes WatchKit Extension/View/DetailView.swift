//
//  DetailView.swift
//  Notes WatchKit Extension
//
//  Created by Fabian Kuschke on 06.09.22.
//

import SwiftUI

struct DetailView: View {
    
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack(alignment: .center, spacing: 3){
            //Header
            HeaderView(title: "")
            //Content
            Spacer()
            ScrollView(.vertical){
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            //Footer
            HStack(alignment: .center){
                Image(systemName: "gear")
                Spacer()
                Text("\(index + 1) / \(count)")
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
            }
            .foregroundColor(.secondary)
        }//Vstack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var note = Note(id: UUID(), text: "test")
    static var previews: some View {
        DetailView(note: note, count: 5, index: 1)
    }
}
