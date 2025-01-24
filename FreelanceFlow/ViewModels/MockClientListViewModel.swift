//
//  MockClientListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class MockClientListViewModel: ClientListViewModel {
    override init(dataStore: DataStore) {
        super.init(dataStore: dataStore)
        setupMockData()
    }

    func setupMockData() {
       clients = [
            Client(id: "client1_id", name: "Mock Client 1", email: "test1@test.com"),
            Client(id: "client2_id", name: "Mock Client 2", email: "test2@test.com"),
        ]
        isLoading = false
    }
}
