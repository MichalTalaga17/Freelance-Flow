//
//  TaskListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct TasksListView: View {
    @StateObject var viewModel: TaskListViewModel

    var body: some View {
        VStack {
             if viewModel.isLoading {
                 LoadingView()
             } else if !viewModel.error.isEmpty {
                Text("Error: \(viewModel.error)")
            } else {
                 List {
                    ForEach(viewModel.tasks, id: \.id) { task in
                        NavigationLink(destination: TaskDetailView(taskId: task.id)){
                            Text(task.name)
                        }
                    }
                }
                 .refreshable {
                    viewModel.fetchTasks()
                }
             }
        }
        .scrollContentBackground(.hidden)
        .onAppear{
            viewModel.fetchTasks()
        }
    }
}

#Preview {
    TasksListView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
}
