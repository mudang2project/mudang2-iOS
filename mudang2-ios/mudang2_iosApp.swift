//
//  mudang2_iosApp.swift
//  mudang2-ios
//
//  Created by ha on 2022/12/19.
//

import SwiftUI
import GoogleMaps


@main
struct mudang2_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            GMSServices.provideAPIKey("AIzaSyD8iL9QpCiKe-R7_y8xCkvKdmAz0vrl3AI")
            return true
        }
}
