// AppTabView.swift

import SwiftUI

struct AppTabView: View {
     @State private var selection: Tab = .overview
    enum Tab {
        case overview, projects, tasks, messages
    }

    var body: some View {
          VStack {
              ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                        tabButton(text: "Overview", tab: .overview)
                      tabButton(text: "Projects", tab: .projects)
                      tabButton(text: "Tasks", tab: .tasks)
                    tabButton(text: "Messages", tab: .messages)
                    }
                }.frame(height: 50)

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
                 }

              Spacer()
          }.navigationTitle("Freelance Flow")
    }
    
    @ViewBuilder
    func tabButton(text: String, tab: Tab) -> some View {
         Button(action: {
             selection = tab
         }) {
            Text(text)
                 .foregroundColor(selection == tab ? .white : .gray)
                .padding(10)
                 .background(selection == tab ? Color.blue : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))

           }
    }
}