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
        _viewModel = StateObject(wrappedValue: TaskDetailViewModel(dataStore: FirebaseDataStore(), taskId: taskId))
    }

    var body: some View {
       ScrollView {
             if viewModel.isLoading {
                 ProgressView()
             } else if !viewModel.error.isEmpty {
                 Text("Error: \(viewModel.error)")
             }else {
              if let task = viewModel.task {
                  VStack(alignment: .leading, spacing: 10) {
                      Text("Task Details").font(.headline)
                          VStack(alignment: .leading) {
                                Text("   Task ID: \(task.id)")
                               Text("  Project ID: \(task.projectId)")
                                Text("  Name: \(task.name)")
                              if let description = task.description {
                                  Text("  Description: \(description)")
                              }
                                Text("  Status: \(task.status.rawValue)")
                                 Text("  Priority: \(task.priority.rawValue)")
                               if let deadline = task.deadline {
                                  Text("  Deadline: \(deadline)")
                              }
                                if let startTime = task.startTime {
                                    Text("  Start Time: \(startTime)")
                                }
                                 if let estimatedTime = task.estimatedTime {
                                     Text("  Estimated Time: \(estimatedTime)")
                                 }
                              if let comments = task.comments {
                                    Text("   Comments: ")
                                     ForEach(comments, id: \.id) { comment in
                                         VStack(alignment: .leading) {
                                            Text("   Comment ID: \(comment.id)")
                                             Text("     Author: \(comment.authorId)")
                                             Text("    Date: \(comment.date)")
                                                Text("    Text: \(comment.text)")
                                            }
                                       }
                                }

                           }
                        }
                  }
            }
        }
    }
}