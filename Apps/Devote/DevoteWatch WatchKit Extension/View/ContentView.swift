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
   
    func deleteItems(offsets: IndexSet){
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
    
    private func deleteItem(item: Item) {
        withAnimation {
            viewContext.delete(item)
            do {
                try viewContext.save()
                print("Deleted")
            } catch {

                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func checkItem(item:Item){
        withAnimation {
            item.completion.toggle()
            do {
                try viewContext.save()
                print("checked")
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
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
                        .font(.system(size: 32, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)                
            }//Hstack
            Spacer()
            
            if items.count > 0 {
                
//                List{
//                    //ForEach(items) { item in
//                    ForEach ( 0..<items.count, id: \.self){ i in
//                        NavigationLink(destination: DetailView(note: Note(id: items[i].id!, task: items[i].task!, timestamp: items[i].timestamp!, completion: items[i].completion), count: items.count, index: i)){
//                            ListRowItemView(item: items[i])
//                        }
//                    }
//                    .onDelete(perform: deleteItems)
//
//                }
                List(items) { item in
                    ListRowItemView(item: item)
                        .swipeActions(edge: .leading) {
                            Button {
                                checkItem(item: item)
                            } label: {
                                Label("Done", systemImage: item.completion ? "circle.dotted" : "checkmark.circle.fill")
                            }
                            .tint(.green)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive, action: {
                                deleteItem(item: item)
                            } ) {
                                Label("Delete", systemImage: "trash")
                            }
                        }
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
        //.navigationTitle("Notes")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
