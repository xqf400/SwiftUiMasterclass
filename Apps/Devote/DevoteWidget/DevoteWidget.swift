//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Fabian Kuschke on 05.09.22.
//

import WidgetKit
import SwiftUI
import CoreData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var fontStyle : Font {
        switch widgetFamily {
        case .accessoryCircular:
            return .system(.footnote, design: .rounded)
        case .systemSmall:
            return .system(.footnote, design: .rounded)
        case .systemMedium:
            return .system(.headline, design: .rounded)
        case .systemLarge:
            return .system(.headline, design: .rounded)
        case .systemExtraLarge:
            return .system(.headline, design: .rounded)
        case .accessoryRectangular:
            return .system(.footnote, design: .rounded)
        case .accessoryInline:
            return .system(.footnote, design: .rounded)
        @unknown default:
            return .system(.headline, design: .rounded)
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                backgroundGradient
                if items.count > 0 {
                    //VStack {
                    ForEach(items) { item in
                        if item.showOnWidget {
                            //Text("\(item.task!)")
                            Text(item.task ?? "")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.medium)
                                .foregroundColor(item.completion ? Color.green : Color.red)
                                .padding(.vertical, 8)
                            
                            Divider()
                        }
                        
                    }
                }else{
                    Text("Empty")
                }
                //}
            }.background(
                backgroundGradient
            )
            
        }
        //Text(entry.date, style: .time)
        /*GeometryReader { geometry in
            HStack{
                backgroundGradient

                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                Image("logo")
                    .resizable()
                    .frame(
                        width: widgetFamily != .systemSmall ? 56 : 36,
                        height: widgetFamily != .systemSmall ? 56 : 36
                    )
                    .offset(
                        x: (geometry.size.width / 2) - 20,
                        y: (geometry.size.height / -2) + 20
                    )
                    .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)

                HStack {

                    Text("Just do it")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0, green: 0, blue: 0, opacity: 0.5)
                                .blendMode(.overlay)
                        )
                    .clipShape(Capsule())
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }

                }//HStack
                .padding()
                .offset(y: (geometry.size.height / 2) - 24)
            }//Zstack
        }//geometry
        .onAppear {
            print("hello")
        }*/
    }
}

@main
struct DevoteWidget: Widget {
    let kind: String = "ToFinishWidget"
    var persistenceController = PersistenceController.shared



    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .configurationDisplayName("ToFinish Widget")
        .description("This is an example widget for the personal task manager.")
        //.supportedFamilies([.accessoryInline, .accessoryCircular, .accessoryRectangular]) //LS support

    }
}

struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemExtraLarge))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}


struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer //NSpersistenCloudContainer

    init(inMemory: Bool = false) {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.fku.ToFinish")!
        let storeURL = containerURL.appendingPathComponent("Notes.plist")
        let description = NSPersistentStoreDescription(url: storeURL)
        //description.cloudKitContainerOptions = nil
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)

        container = NSPersistentCloudKitContainer(name: "Notes")
        container.persistentStoreDescriptions = [description]
        if inMemory {
            print("in memory")
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

    }
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<3 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = "sample \(i)"
            newItem.completion = Bool.random()
            newItem.showOnWidget = Bool.random()
            newItem.id = UUID()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    


    
}

