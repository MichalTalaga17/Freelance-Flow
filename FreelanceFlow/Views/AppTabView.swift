//
//  AppTabView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


// AppTabView.swift

import SwiftUI

struct AppTabView: View {
    @State private var selection: Tab = .overview
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Freelance Flow")
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(.horizontal, 10)
            HStack (alignment: .center){
                tabButton(text: "Overview", tab: .overview)
                tabButton(text: "Projects", tab: .projects)
                tabButton(text: "Tasks", tab: .tasks)
                //tabButton(text: "Messages", tab: .messages)
            }
            VStack {
                switch selection {
                case .overview:
                    OverviewView()
                case .projects:
                    ProjectsView(viewModel: ProjectListViewModel(dataStore: FirebaseDataStore()))
                case .tasks:
                    TasksView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
                }
                Spacer()
            }
        }
   
    }
    @ViewBuilder
    func tabButton(text: String, tab: Tab) -> some View {
        Button(action: {
            selection = tab
        }) {
            VStack(spacing: 0) {
                Text(text)
                    .foregroundColor(selection == tab ? .primary : .primary.opacity(0.3))
                    .font(.headline .weight(.heavy))
                    .padding(.vertical, 10)
                
                Rectangle()
                    .fill(selection == tab ? .primary : Color.clear)
                    .frame(height: 2)
            }
        }
    }
    
}

#Preview {
    NavigationView {
        AppTabView()
    }
}

//struct AppTabView: View {
//    var body: some View {
//        TabView {
//            OverviewView()
//                .tabItem {
//                    Label("Overview", systemImage: "house")
//                }
//            
//            ProjectListView(viewModel: ProjectListViewModel(dataStore: FirebaseDataStore()))
//                .tabItem {
//                    Label("Projects", systemImage: "folder")
//                }
//            
//            TaskListView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
//                .tabItem {
//                    Label("Tasks", systemImage: "checkmark.circle")
//                }
//            
//            MessagesView() // Zamień na rzeczywisty widok wiadomości
//                .tabItem {
//                    Label("Messages", systemImage: "message")
//                }
//        }
//        .navigationTitle("Freelance Flow") // Ustawia tytuł dla widoków w TabView
//        .toolbarTitleDisplayMode(.large) // Wymusza duży tytuł
//    }
//}
