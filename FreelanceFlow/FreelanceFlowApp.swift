//
//  FreelanceFlowApp.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 18/01/2025.
//

import SwiftUI
import FirebaseCore

@main
struct FreelanceFlowApp: App {

    init() {
         FirebaseApp.configure()
     }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
