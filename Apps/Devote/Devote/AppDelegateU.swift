//
//  AppDelegateU.swift
//  Devote
//
//  Created by Fabian Kuschke on 08.09.22.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Start")
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("background")
    }
}
