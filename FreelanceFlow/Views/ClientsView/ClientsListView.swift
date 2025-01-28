//
//  ClientListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ClientsListView: View {
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
                        NavigationLink(
                            destination: ClientDetailView(clientId: client.id)
                        ) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(client.name)
                                    .font(.headline.bold())
                                    .foregroundColor(.primary)
                            
                                if let adress = client.address, !adress.isEmpty{
                                    Text(adress)
                                        .font(
                                            .subheadline.weight(.medium)
                                        )
                                        .foregroundColor(
                                            .primary.opacity(0.6)
                                        )
                                }
                                
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.fetchClients()
                }
            }
        }
    }
}

#Preview {
    ClientsView(
        viewModel: ClientListViewModel(dataStore: FirebaseDataStore()))
}
