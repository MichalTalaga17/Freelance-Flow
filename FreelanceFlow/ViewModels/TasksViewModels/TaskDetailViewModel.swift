//
//  TaskDetailViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class TaskDetailViewModel: ObservableObject {
    @Published var task: ProjectTask?
    @Published var isLoading: Bool = false
    @Published var error: String = ""

    private let dataStore: DataStore
    private let taskId: String

    init(dataStore: DataStore, taskId: String) {
        self.dataStore = dataStore
        self.taskId = taskId
        fetchTask()
    }

    func fetchTask() {
        isLoading = true
        dataStore.fetchTask(id: taskId) { [weak self] task in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let task = task {
                    self?.task = task
                } else {
                    self?.error = "Failed to fetch task with id \(self?.taskId ?? "")"
                }
            }
        }
    }

    func deleteTask(completion: @escaping (Bool) -> Void) {
        isLoading = true
        dataStore.deleteTask(id: taskId) { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    completion(true)
                } else {
                    self?.error = "Failed to delete task."
                    completion(false)
                }
            }
        }
    }
}
