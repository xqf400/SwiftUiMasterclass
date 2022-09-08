//
//  DevoteApp.swift
//  Devote
//
//  Created by Fabian Kuschke on 22.08.22.
//

import SwiftUI


@main
struct DevoteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark: .light)
        }
    }
}
