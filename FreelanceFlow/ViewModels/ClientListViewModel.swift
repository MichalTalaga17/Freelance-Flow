//
//  ClientListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class ClientListViewModel : ObservableObject {
    @Published var clients: [Client] = []
      @Published var isLoading: Bool = false
     @Published var error: String = ""
    private let dataStore : DataStore

    init(dataStore: DataStore) {
        self.dataStore = dataStore
        fetchClients()
    }
    
    func fetchClients(){
          isLoading = true
           dataStore.fetchClients { [weak self] clients in
               self?.isLoading = false
                if let clients = clients {
                    self?.clients = clients
                } else {
                    self?.error = "Failed to fetch clients"
                }
            }
      }
}