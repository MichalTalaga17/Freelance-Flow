//
//  TaskListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct TasksView: View {
    @StateObject var viewModel: TaskListViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingAddTaskView: Bool = false
    
    var body: some View {
        VStack{
            TasksListView(viewModel: viewModel)
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingAddTaskView.toggle()
                    }) {
                        Text("Add New Task")
                            .padding()
                            .background(Color.primary)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .cornerRadius(8)
                    }
                    .padding()
                    .sheet(isPresented: $isShowingAddTaskView) {
                        AddTaskView(onSave: { newTask in
                            viewModel.addTask(newTask)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    TasksView(viewModel: TaskListViewModel(dataStore: FirebaseDataStore()))
}
