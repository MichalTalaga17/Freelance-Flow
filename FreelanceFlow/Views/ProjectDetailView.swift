//
//  ProjectDetailView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


// ProjectDetailView.swift
import SwiftUI

struct ProjectDetailView: View {
    let projectId: String
     @StateObject var viewModel : ProjectDetailViewModel

    init(projectId: String) {
        self.projectId = projectId
        _viewModel = StateObject(wrappedValue: ProjectDetailViewModel(dataStore: FirebaseDataStore(), projectId: projectId))
    }

    var body: some View {
       ScrollView {
             if viewModel.isLoading {
                 ProgressView()
             } else if !viewModel.error.isEmpty {
                 Text("Error: \(viewModel.error)")
             }else {
              if let project = viewModel.project {
                  VStack(alignment: .leading, spacing: 10) {
                      Text("Project Details").font(.headline)
                           VStack(alignment: .leading) {
                               Text("  Project ID: \(project.id)")
                               Text("  Name: \(project.name)")
                                 if let description = project.description {
                                   Text("  Description: \(description)")
                               }
                                if let deadline = project.deadline {
                                  Text("  Deadline: \(deadline)")
                                }
                             Text("  Status: \(project.status.rawValue)")
                             if let clientID = project.clientId {
                                Text("  Client ID: \(clientID)")
                              }
                             if let goals = project.goals {
                                Text("  Goals: \(goals)")
                            }
                              if let milestones = project.milestones {
                                Text("  Milestones: ")
                                ForEach(milestones, id: \.id) { milestone in
                                   VStack(alignment: .leading) {
                                       Text("    Milestone ID: \(milestone.id)")
                                      Text("    Name: \(milestone.name)")
                                     if let milestoneDescription = milestone.description {
                                        Text("    Description: \(milestoneDescription)")
                                       }
                                     if let milestoneDeadline = milestone.deadline {
                                       Text("    Deadline: \(milestoneDeadline)")
                                    }
                                     Text("    Status: \(milestone.status.rawValue)")

                                 }
                             }
                         }
                            if let budget = project.budget {
                                  Text("  Budget: \(budget)")
                             }
                           if let actualCost = project.actualCost {
                                Text("  Actual Cost: \(actualCost)")
                              }
                             if let tags = project.tags {
                                Text("  Tags: \(tags)")
                              }
                              if let progress = project.progress {
                                 Text("  Progress: \(progress)")
                                }

                          }


                        }

                   }
           }
        }
    }
}
