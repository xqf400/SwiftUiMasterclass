//
//  ContentView.swift
//  Devote
//
//  Created by Fabian Kuschke on 22.08.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: Vars
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem : Bool = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    //MARK: Functions

    private func deleteItems(offsets: IndexSet) {
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
    
    
    //MARK: BODY
    var body: some View {
        NavigationView {
            ZStack {
                //MARK: Main View
                VStack {
                    //MARK: Header
                    HStack(spacing: 10){
                        //Title
                        Text("To Finish")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                            .foregroundColor(isDarkMode ? Color.black: Color.white)
                        Spacer(minLength: 100)
                        /*
                         //Edit button
                         EditButton()
                         .font(.system(size: 16, weight: .semibold, design: .rounded))
                         .padding(.horizontal, 10)
                         .frame(minWidth: 70, minHeight: 24)
                         .background(
                         Capsule().stroke(isDarkMode ? Color.black: Color.white, lineWidth: 2)
                         )
                         .foregroundColor(isDarkMode ? Color.black: Color.white)
                         */
                        //Appearence button
                        Button {
                            print("Credits Screen")
                        } label: {
                            Image(systemName: isDarkMode ? "person.2.circle.fill": "person.2.circle")
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                        .foregroundColor(isDarkMode ? Color.black: Color.white)
                        Spacer()
                        Button {
                            //Toggle Apperance
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        } label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill": "moon.circle")
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        }
                        .foregroundColor(isDarkMode ? Color.black: Color.white)
                    }
                    .padding()
                    .foregroundColor(.white)
                    Spacer(minLength: 0)

                    //MARK: Tasks
                    if #available(iOS 16.0, *) {
                        List(items.indexed(), id: \.1.self) { idx, item in
                            //List{
                            //ForEach(items) { item in
                            //NavigationLink(destination: ){
                            ListRowItemView(item: item)
                            
                                .swipeActions(edge: .leading) {
                                    Button {
                                        checkItem(item: item)
                                    } label: {
                                        Label("Done", systemImage: item.completion ? "circle.dotted" : "checkmark.circle.fill")
                                            .clipShape(Circle())
                                    }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive, action: {
                                        deleteItem(item: item)
                                    } ) {
                                        Label("Delete", systemImage: "trash")
                                            .clipShape(Circle())
                                    }
                                    .clipShape(Capsule())
                                }
                                .listRowBackground(
                                    LinearGradient(gradient: Gradient(colors: [Color("mygreen"), Color.orange]), startPoint: .leading, endPoint: .trailing)
                                    //.clipShape(Capsule())
                                )
                                .listRowSeparatorTint(Color.blue)
                            
                            //}//NAV
                            //}//Foreach
                            //.onDelete(perform: deleteItems)
                        }//LIST
                        .scrollContentBackground(.hidden)
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0)
                        .frame(maxWidth: 640)
                    } else {
                        // Fallback on earlier versions
                        List(items.indexed(), id: \.1.self) { idx, item in
                            //List{
                            //ForEach(items) { item in
                            //NavigationLink(destination: ){
                            ListRowItemView(item: item)
                            
                                .swipeActions(edge: .leading) {
                                    Button {
                                        checkItem(item: item)
                                    } label: {
                                        Label("Done", systemImage: item.completion ? "circle.dotted" : "checkmark.circle.fill")
                                            .clipShape(Circle())
                                    }
                                    .tint(.green)
                                }
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive, action: {
                                        deleteItem(item: item)
                                    } ) {
                                        Label("Delete", systemImage: "trash")
                                            .clipShape(Circle())
                                    }
                                    .clipShape(Capsule())
                                }
                                .listRowBackground(
                                    LinearGradient(gradient: Gradient(colors: [Color("mygreen"), Color.orange]), startPoint: .leading, endPoint: .trailing)
                                    //.clipShape(Capsule())
                                )
                                .listRowSeparatorTint(Color.blue)
                            
                            //}//NAV
                            //}//Foreach
                            //.onDelete(perform: deleteItems)
                        }//LIST
                        .listStyle(InsetGroupedListStyle())
                        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                        .padding(.vertical, 0)
                        .frame(maxWidth: 640)
                    }
                    
                    //MARK: New Task button
                    Button {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success)
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                            .foregroundColor(isDarkMode ? Color.black: Color.white)
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(isDarkMode ? Color.black: Color.white)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 60)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0, y: 4)
                }//vstack
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .top))
                .animation(.easeOut(duration: 0.5))//easeOut(duration: 0.5))
                
                //MARK: New Task
                if showNewTaskItem{
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                    .onTapGesture {
                        withAnimation {
                            showNewTaskItem = false
                        }
                    }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }else{
                    
                }
            }//zstack
            .onAppear(){
                UITableView.appearance().backgroundColor = .clear
            }
            .navigationBarTitle("Daily Tasks", displayMode: .large)
            .navigationBarHidden(true)
            
//            .background(
//                BackgroundImageView()
//                    .blur(radius: showNewTaskItem ? 1.0 : 0, opaque: false)
//            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        }//navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}//eoc



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
