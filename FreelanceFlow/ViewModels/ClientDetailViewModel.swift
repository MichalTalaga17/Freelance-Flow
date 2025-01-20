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

    private let dataStore : DataStore
    private let clientId: String

    init(dataStore: DataStore, clientId: String) {
        self.dataStore = dataStore
        self.clientId = clientId
        fetchClient()
    }

     func fetchClient(){
         isLoading = true
          dataStore.fetchClient(id: clientId) { [weak self] client in
             self?.isLoading = false
            if let client = client {
                self?.client = client
              } else {
                  self?.error = "Failed to fetch client with id \(self?.clientId ?? "")"
            }
         }
   }
}
