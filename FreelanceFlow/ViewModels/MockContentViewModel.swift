//
//  MockContentViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//
import Foundation

class MockContentViewModel: ContentViewModel {
    override init(dataStore: DataStore) {
        super.init(dataStore: dataStore)
        setupMockData()
    }
    
    func setupMockData() {
        projects = [
            Project(id: "project1_id", name: "Mock Project 1", description: "Mock description 1", deadline: Date(), status: .inProgress, clientId: "client1_id", budget: 1200),
            Project(id: "project2_id", name: "Mock Project 2", description: "Mock description 2", deadline: Date(), status: .pending, clientId: "client2_id", budget: 2300),
        ]
        clients = [
            Client(id: "client1_id", name: "Mock Client 1", email: "test1@test.com"),
            Client(id: "client2_id", name: "Mock Client 2", email: "test2@test.com"),
        ]
        tasks = [
            Task(id: "task1_id", projectId: "project1_id", name: "Mock Task 1",  description: nil, status: .inProgress, priority: .high, deadline: Date()),
            Task(id: "task2_id", projectId: "project2_id", name: "Mock Task 2", description: nil,  status: .todo, priority: .normal, deadline: Date()),
        ]
        isLoading = false
    }
}
