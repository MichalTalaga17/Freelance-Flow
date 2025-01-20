//
//  MockTaskListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class MockTaskListViewModel: TaskListViewModel {
    override init(dataStore: DataStore) {
        super.init(dataStore: dataStore)
        setupMockData()
    }
    
    func setupMockData() {
           tasks = [
              Task(id: "task1_id", projectId: "project1_id", name: "Mock Task 1", description: nil, status: .inProgress, priority: .high, deadline: Date()),
              Task(id: "task2_id", projectId: "project2_id", name: "Mock Task 2", description: nil, status: .todo, priority: .normal, deadline: Date()),
          ]
           isLoading = false
    }
}