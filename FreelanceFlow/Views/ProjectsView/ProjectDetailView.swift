//
//  ProjectDetailView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ProjectDetailView: View {
    let projectId: String
    @StateObject var viewModel: ProjectDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    init(projectId: String) {
        self.projectId = projectId
        _viewModel = StateObject(
            wrappedValue: ProjectDetailViewModel(
                dataStore: FirebaseDataStore(),
                projectId: projectId
            )
        )
    }

    @MainActor
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if !viewModel.error.isEmpty {
                        Text("Error: \(viewModel.error)")
                            .foregroundColor(.red)
                    } else if let project = viewModel.project {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Project Details")
                                .font(.title2)
                                .bold()
                            Text("Project ID: \(project.id)")
                            Text("Name: \(project.name)")
                            
                            if let description = project.description, !description.isEmpty {
                                Text("Description:")
                                    .font(.headline)
                                Text(description)
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            if let deadline = project.deadline {
                                Text("Deadline: \(deadline)")
                            }
                            
                            Text("Status: \(project.status.rawValue)")
                            
                            if let clientID = project.clientId {
                                Text("Client ID: \(clientID)")
                            }
                            
                            if let goals = project.goals, !goals.isEmpty {
                                Text("Goals:")
                                    .font(.headline)
                                ForEach(goals, id: \.self) { goal in
                                    Text("- \(goal)")
                                }
                            }
                            
                            if let milestones = project.milestones, !milestones.isEmpty {
                                Text("Milestones:")
                                    .font(.headline)
                                ForEach(milestones, id: \.id) { milestone in
                                    VStack(alignment: .leading) {
                                        Text("   Milestone ID: \(milestone.id)")
                                        Text("   Name: \(milestone.name)")
                                        if let milestoneDescription = milestone.description {
                                            Text("   Description: \(milestoneDescription)")
                                        }
                                        if let milestoneDeadline = milestone.deadline {
                                            Text("   Deadline: \(milestoneDeadline)")
                                        }
                                        Text("   Status: \(milestone.status.rawValue)")
                                    }
                                }
                            }
                            
                            if let budget = project.budget {
                                Text("Budget: \(budget)")
                            }
                            
                            if let actualCost = project.actualCost {
                                Text("Actual Cost: \(actualCost)")
                            }
                            
                            if let tags = project.tags, !tags.isEmpty {
                                Text("Tags:")
                                    .font(.headline)
                                ForEach(tags, id: \.self) { tag in
                                    Text("- \(tag)")
                                }
                            }
                            
                            if let progress = project.progress {
                                Text("Progress: \(progress)")
                            }
                            
                            Button(action: deleteProject) {
                                Text("Usuń projekt")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10)

                        Spacer()
                    }
                }
                .padding()
            }
        }
    }

    private func deleteProject() {
        viewModel.dataStore.deleteProject(id: projectId) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                viewModel.error = "Failed to delete project."
            }
        }
    }
}

#Preview {
    ProjectDetailView(projectId: "project1_id")
}
