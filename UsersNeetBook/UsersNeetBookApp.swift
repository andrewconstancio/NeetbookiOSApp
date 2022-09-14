//
//  UsersNeetBookApp.swift
//  UsersNeetBook
//
//  Created by Andrew Constancio on 5/9/22.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct UsersNeetBookApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delgate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
