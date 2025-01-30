//
//  ClientDetailViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class ClientDetailViewModel : ObservableObject {
    @Published var client: Client?
    @Published var isLoading: Bool = false
    @Published var error: String = ""

    let dataStore: DataStore
    private let clientId: String

    init(dataStore: DataStore, clientId: String) {
        self.dataStore = dataStore
        self.clientId = clientId
        fetchClient()
    }

    func fetchClient() {
        isLoading = true
        dataStore.fetchClient(id: clientId) { [weak self] client in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let client = client {
                    self?.client = client
                } else {
                    self?.error = "Failed to fetch client with id \(self?.clientId ?? "")"
                }
            }
        }
    }

    func deleteClient(completion: @escaping (Bool) -> Void) {
        dataStore.deleteClient(id: clientId) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    completion(true)
                } else {
                    self?.error = "Failed to delete client."
                    completion(false)
                }
            }
        }
    }
}
