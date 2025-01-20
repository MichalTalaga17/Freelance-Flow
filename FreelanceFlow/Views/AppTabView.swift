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
    enum Tab {
        case overview, projects, tasks, messages
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                tabButton(text: "Overview", tab: .overview)
                tabButton(text: "Projects", tab: .projects)
                tabButton(text: "Tasks", tab: .tasks)
                tabButton(text: "Messages", tab: .messages)
            }
            .padding(.horizontal, 10)
            
            Spacer()
            
            switch selection {
            case .overview:
                Text("Overview")
            case .projects:
                ProjectListView(viewModel: ProjectListViewModel(dataStore: FirebaseDataStore()))
            case .tasks:
                TaskListView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
            case .messages:
                Text("Messages")
                    .font(.custom("Roboto", size: 40))
            }
            
            Spacer()
        }.navigationTitle("Freelance Flow")
            
    }
    
    @ViewBuilder
    func tabButton(text: String, tab: Tab) -> some View {
        Button(action: {
            selection = tab
        }) {
            VStack(spacing: 0) {
                Text(text)
                    .foregroundColor(selection == tab ? .black : .gray)
                    .padding(.vertical, 10)
                    
                Rectangle()
                    .fill(selection == tab ? Color.black : Color.clear)
                    .frame(height: 2)
            }
        }
    }
}
