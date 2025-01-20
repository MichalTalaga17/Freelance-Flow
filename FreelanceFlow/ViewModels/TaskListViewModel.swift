//
//  TaskListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class TaskListViewModel : ObservableObject {
    @Published var tasks: [Task] = []
     @Published var isLoading: Bool = false
    @Published var error: String = ""

    private let dataStore : DataStore

    init(dataStore: DataStore) {
        self.dataStore = dataStore
        fetchTasks()
    }
    
    func fetchTasks(){
          isLoading = true
          dataStore.fetchTasks { [weak self] tasks in
             self?.isLoading = false
                if let tasks = tasks {
                      self?.tasks = tasks
                  } else {
                    self?.error = "Failed to fetch tasks"
                  }
            }
        }
}
