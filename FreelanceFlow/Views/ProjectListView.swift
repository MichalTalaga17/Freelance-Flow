//
//  ProjectsListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ProjectListView: View {
    @StateObject var viewModel: ProjectListViewModel

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if !viewModel.error.isEmpty {
                    Text("Error: \(viewModel.error)")
                } else {
                    List {
                        ForEach(viewModel.projects, id: \.id) { project in
                            NavigationLink(destination: ProjectDetailView(projectId: project.id)){
                                VStack (alignment: .leading) {
                                        Text(project.name)
                                           .font(.headline.bold())
                                            .foregroundColor(.black)
                                        Text("Project ID: \(project.id)")
                                            .foregroundColor(.black)
                                    }
                            }
                             .buttonStyle(.plain)
                        }
                    }
                   .scrollContentBackground(.hidden)
                }
            }
        }
    }
}

#Preview {
    ProjectListView(viewModel: MockProjectListViewModel(dataStore: FirebaseDataStore()))
}
