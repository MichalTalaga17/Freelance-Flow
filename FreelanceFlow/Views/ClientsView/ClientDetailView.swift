//
//  ClientDetailView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import SwiftUI

struct ClientDetailView: View {
    let clientId: String
    @StateObject var viewModel : ClientDetailViewModel
    @Environment(\.presentationMode) var presentationMode

    init(clientId: String) {
        self.clientId = clientId
        _viewModel = StateObject(
            wrappedValue: ClientDetailViewModel(
                dataStore: FirebaseDataStore(),
                clientId: clientId
            )
        )
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if !viewModel.error.isEmpty {
                        Text("Error: \(viewModel.error)")
                            .foregroundColor(.red)
                    } else if let client = viewModel.client {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Client Details")
                                .font(.title2)
                                .bold()
                       
                            Text("Client ID: \(client.id)")
                           
                            Text("Name: \(client.name)")
                         
                            if let email = client.email {
                                Text("Email: \(email)")
                            }
                         
                            if let phoneNumber = client.phoneNumber {
                                Text("Phone: \(phoneNumber)")
                            }
                        
                            if let address = client.address {
                                Text("Address: \(address)")
                            }
                    
                            if let notes = client.notes, !notes.isEmpty {
                                Text("Notes:")
                                    .font(.headline)
                                Text(notes)
                                    .padding(.vertical, 5)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                            }
                    
                            if let tags = client.tags, !tags.isEmpty {
                                Text("Tags:")
                                    .font(.headline)
                                ForEach(tags, id: \.self) { tag in
                                    Text("- \(tag)")
                                }
                            }

                            Button(action: deleteClient) {
                                Text("Usuń klienta")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }

    private func deleteClient() {
        viewModel.dataStore.deleteClient(id: clientId) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                viewModel.error = "Failed to delete client."
            }
        }
    }
}

#Preview {
    ClientDetailView(clientId: "client1_id")
}
