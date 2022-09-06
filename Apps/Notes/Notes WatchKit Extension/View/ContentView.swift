//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Fabian Kuschke on 06.09.22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Proptery
    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //MARK: Functions
    
    func save() {
        //dump(notes) // see in console
        do{
            let data = try JSONEncoder().encode(notes)
            let url = getDokumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        }catch{
            print("Saving data has failed")
        }
    }
    
    func load(){
        DispatchQueue.main.async {
            do{
                let url = getDokumentDirectory().appendingPathComponent("notes")

                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            }catch{
                //nothing no notes
            }
        }
    }
    
    func delete(offsets: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func getDokumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    //MARK: Body
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add new Note", text: $text)
                Button {
                    guard text.isEmpty == false else {return}
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
                //.buttonStyle(BorderedButtonStyle(tint: .accentColor))

            }//Hstack
            Spacer()

            List{
                ForEach ( 0..<notes.count, id: \.self){ i in
                    HStack{
                        Capsule()
                            .frame(width: 4)
                            .foregroundColor(.accentColor)
                        Text(notes[i].text)
                            .lineLimit(1)
                            .padding(.leading, 5)
                        
                    }//Hstack
                }//Loop
                .onDelete(perform: delete)
            }//List
        }//Vstack
        .navigationTitle("Notes")
        .onAppear {
            load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
