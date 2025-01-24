//
//  AppTabView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .projects

    var body: some View {
        TabView(selection: $selection) {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            ProjectsView(
                viewModel: ProjectListViewModel(
                    dataStore: FirebaseDataStore()))
                .tabItem {
                    Label("Projects", systemImage: "macwindow.on.rectangle")
                }
            TasksView(
                viewModel: TaskListViewModel(
                    dataStore: FirebaseDataStore()))
                .tabItem {
                    Label("Tasks", systemImage: "checkmark.circle")
                }
            ClientsView(
                viewModel: ClientListViewModel(
                    dataStore: FirebaseDataStore()))
                .tabItem {
                    Label("Clients", systemImage: "person.2.fill")
                }
        
        }

//        VStack(spacing: 0) {
//            HStack {
//                Text("Freelance Flow")
//                    .font(.title.bold())
//                Spacer()
//            }
//            .padding(10)
//            HStack(alignment: .center) {
//                tabButton(text: "Overview", tab: .overview)
//                tabButton(text: "Projects", tab: .projects)
//                tabButton(text: "Tasks", tab: .tasks)
//                tabButton(text: "Clients", tab: .clients)
//            }
//            .overlay(
//                Rectangle()
//                    .frame(height: 1)
//                    .foregroundColor(Color.primary.opacity(0.1))
//                    .padding(.top, 20),
//                alignment: .bottom
//            )
//            VStack {
//                switch selection {
//                case .overview:
//                    DashboardView()
//                case .projects:
//                    ProjectsView(
//                        viewModel: ProjectListViewModel(
//                            dataStore: FirebaseDataStore()))
//                case .tasks:
//                    TasksView(
//                        viewModel: TaskListViewModel(
//                            dataStore: FirebaseDataStore()))
//                case .clients:
//                    ClientsView(
//                        viewModel: ClientListViewModel(
//                            dataStore: FirebaseDataStore()))
//                }
//                Spacer()
//            }
//        }

    }
//    @ViewBuilder
//    func tabButton(text: String, tab: Tab) -> some View {
//        Button(action: {
//            selection = tab
//        }) {
//            VStack(spacing: 0) {
//                Text(text)
//                    .foregroundColor(
//                        selection == tab ? .primary : .primary.opacity(0.3)
//                    )
//                    .font(.headline.weight(.heavy))
//                    .padding(.vertical, 10)
//
//                Rectangle()
//                    .fill(selection == tab ? .primary : Color.clear)
//                    .frame(height: 2)
//            }
//        }
//    }

}

#Preview {
    NavigationView {
        ContentView()
    }
}
