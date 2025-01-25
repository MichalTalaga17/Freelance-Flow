//
//  ProjectsListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject var viewModel: ProjectListViewModel
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else if !viewModel.error.isEmpty {
                Text("Error: \(viewModel.error)")
            } else {
                NavigationView{
                    List {
                       ForEach(viewModel.projects, id: \.id) { project in
                            NavigationLink(destination: ProjectDetailView(projectId: project.id)) {
                              VStack(alignment: .leading, spacing: 5) {
                                  Text(project.name)
                                      .font(.headline.bold())
                                     .foregroundColor(.primary)
                                
                                   if let description = project.description, !description.isEmpty{
                                        Text(description)
                                           .font(.subheadline.weight(.medium))
                                            .foregroundColor(.primary.opacity(0.6))
                                   }
                                   HStack {
                                       Text("Status: \(project.status.rawValue)")
                                         .font(.caption)
                                       Spacer()
                                     if let deadline = project.deadline {
                                         Text("Deadline: \(deadline, formatter: dateFormatter)")
                                             .font(.caption)
                                       }
                                   }
                               }
                           }
                            .listRowSeparator(.automatic)
                            .listRowBackground(Color.primary.opacity(0.1))
                           .padding(.vertical, 5)
                       }
                    }
                     .scrollContentBackground(.hidden)
                }
                
            }
        }
        
    }
}
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

#Preview {
    ProjectsView(
        viewModel: MockProjectListViewModel(dataStore: FirebaseDataStore())
    )
}
