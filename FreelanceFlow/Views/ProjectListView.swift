//
//  ProjectsListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

// ProjectListView.swift
import SwiftUI

struct ProjectListView: View {
    @StateObject var viewModel: ProjectListViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.error.isEmpty {
                Text("Error: \(viewModel.error)")
            } else {
                List {
                    ForEach(viewModel.projects, id: \.id) { project in
                         NavigationLink(destination: ProjectDetailView(projectId: project.id)){
                         Text(project.name)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ProjectListView(viewModel: MockProjectListViewModel(dataStore: FirebaseDataStore()))
}
