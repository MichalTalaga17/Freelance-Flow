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
                tabButton(text: "Messages", tab: .messages)
            }
            VStack {
                switch selection {
                case .overview:
                    OverviewView()
                case .projects:
                    ProjectListView(viewModel: ProjectListViewModel(dataStore: FirebaseDataStore()))
                case .tasks:
                    TaskListView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
                case .messages:
                    Text("Messages")
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
                    .font(.subheadline.bold())
                    .padding(.vertical, 10)
                
                Rectangle()
                    .fill(selection == tab ? .primary : Color.clear)
                    .frame(height: 1)
            }
        }
    }
    
}

#Preview {
    NavigationView {
        AppTabView()
    }
}
