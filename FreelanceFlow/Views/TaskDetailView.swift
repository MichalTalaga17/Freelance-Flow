//
//  TaskDetailView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct TaskDetailView: View {
    let taskId: String
    @StateObject var viewModel : TaskDetailViewModel

    init(taskId: String) {
        self.taskId = taskId
        _viewModel = StateObject(
            wrappedValue: TaskDetailViewModel(
                dataStore: FirebaseDataStore(),
                taskId: taskId
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if !viewModel.error.isEmpty {
                        Text("Error: \(viewModel.error)")
                            .foregroundColor(.red)
                    } else if let task = viewModel.task {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Task Details")
                                .font(.title2)
                                .bold()
                            
                            Text("Task ID: \(task.id)")
                            Text("Project ID: \(task.projectId)")
                            Text("Name: \(task.name)")
                             
                            if let description = task.description, !description.isEmpty {
                                Text("Description:")
                                    .font(.headline)
                                Text(description)
                                    .padding(.vertical, 5)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                            }
                            
                            Text("Status: \(task.status.rawValue)")
                            Text("Priority: \(task.priority.rawValue)")
                            
                            if let deadline = task.deadline {
                                Text("Deadline: \(deadline)")
                            }
                            if let startTime = task.startTime {
                                Text("Start Time: \(startTime)")
                            }
                            if let estimatedTime = task.estimatedTime {
                                Text("Estimated Time: \(estimatedTime)")
                            }
                            if let comments = task.comments, !comments.isEmpty {
                                Text("Comments:")
                                    .font(.headline)
                                ForEach(comments, id: \.id) { comment in
                                    VStack(alignment: .leading) {
                                        Text(" Comment ID: \(comment.id)")
                                        Text("   Author: \(comment.authorId)")
                                        Text("   Date: \(comment.date)")
                                        Text("   Text: \(comment.text)")
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    TaskDetailView(taskId: "task1_id")
}
