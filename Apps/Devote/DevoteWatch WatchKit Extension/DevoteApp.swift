//
//  DevoteApp.swift
//  DevoteWatch WatchKit Extension
//
//  Created by Fabian Kuschke on 08.09.22.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
