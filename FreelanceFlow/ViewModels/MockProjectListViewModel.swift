//
//  MockProjectListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation

class MockProjectListViewModel: ProjectListViewModel {
    override init(dataStore: DataStore) {
        super.init(dataStore: dataStore)
        setupMockData()
    }

    func setupMockData() {
        projects = [
            Project(id: "project1_id", name: "Mock Project 1", description: "Mock description 1", deadline: Date(), status: .inProgress, clientId: "client1_id", budget: 1200),
            Project(id: "project2_id", name: "Mock Project 2",  description: "Mock description 2", deadline: Date(), status: .pending, clientId: "client2_id", budget: 2300),
        ]
        isLoading = false
    }
}
