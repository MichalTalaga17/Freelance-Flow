//
//  ClientListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct ClientsView: View {
    @StateObject var viewModel: ClientListViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            } else if !viewModel.error.isEmpty {
                Text("Error: \(viewModel.error)")
            } else {
                List {
                    ForEach(viewModel.clients, id: \.id) { client in
                         NavigationLink(destination: ClientDetailView(clientId: client.id)){
                             Text(client.name)
                         }
                    }
                }
            }
        }
    }
}


#Preview {
    ClientsView(viewModel: MockClientListViewModel(dataStore: FirebaseDataStore()))
}
