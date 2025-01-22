//
//  TaskListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct TasksView: View {
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
             }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    TasksView(viewModel: MockTaskListViewModel(dataStore: FirebaseDataStore()))
}
