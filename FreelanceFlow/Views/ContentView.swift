//
//  ContentView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                 NavigationLink(destination: ProjectListView(viewModel: ProjectListViewModel(dataStore: FirebaseDataStore()))) {
                    Text("Projects")
                }
                NavigationLink(destination: ClientListView(viewModel: ClientListViewModel(dataStore: FirebaseDataStore()))) {
                   Text("Clients")
                }
                NavigationLink(destination: TaskListView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))) {
                   Text("Tasks")
               }
            }
            .navigationTitle("Freelance Flow")

       }
    }
}

#Preview {
    ContentView()
}
