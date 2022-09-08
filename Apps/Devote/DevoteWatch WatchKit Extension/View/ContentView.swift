//
//  ContentView.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: Proptery
    //@State private var notes: [Note] = [Note]()
    @State private var task: String = ""
    
    @AppStorage("lineCount") var lineCount: Int = 1
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: Functions
    
    func save() {
        //dump(notes) // see in console
        /*
        do{
            let data = try JSONEncoder().encode(notes)
            let url = getDokumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        }catch{
            print("Saving data has failed")
        }*/
    }
    
    func load(){
        /*
        DispatchQueue.main.async {
            do{
                let url = getDokumentDirectory().appendingPathComponent("notes")

                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            }catch{
                //nothing no notes
            }
        }*/
    }
    
    func deleteItems(offsets: IndexSet){
//        withAnimation {
//            notes.remove(atOffsets: offsets)
//            save()
//        }
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
//    func getDokumentDirectory() -> URL {
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return path[0]
//    }
    
    //MARK: Body
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add new Note", text: $task)
                Button {
                    guard task.isEmpty == false else {return}
                    //let note = Note(id: UUID(), task: task, timestamp: Date(), completion: false)
                    //notes.append(note)
                    
                    let newItem = Item(context: viewContext)
                    newItem.timestamp = Date()
                    newItem.task = task
                    newItem.completion = false
                    newItem.id = UUID()
                    
                    do {
                    try viewContext.save()
                    } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                    
                    task = ""
                    //save()
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

            if items.count > 0 {

                List{
                    ForEach(items) { item in
                       ListRowItemView(item: item)
                    }
                    .onDelete(perform: deleteItems)
                    /*
                    ForEach ( 0..<items.count, id: \.self){ i in
                        NavigationLink(destination: DetailView(note: Note(id: items[i].id!, task: items[i].task!, timestamp: items[i].timestamp!, completion: items[i].completion), count: items.count, index: i)){
                            HStack{
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(items[i].task!)
                                    .lineLimit(lineCount)
                                    .padding(.leading, 5)
                                
                            }//Hstack
                        }//nav
                    }//Loop
                    .onDelete(perform: deleteItems)*/
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.accentColor)
                    .padding(25)
                    .opacity(0.25)
                Spacer()
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
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
