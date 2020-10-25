//
//  PDB_Client_AppApp.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI
import Firebase

@main
struct PDB_Client_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomePage()
            }.navigationBarHidden(true)
            .navigationTitle("")
        }
    }
}
