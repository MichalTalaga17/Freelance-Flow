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

    init(clientId: String) {
        self.clientId = clientId
        _viewModel = StateObject(wrappedValue: ClientDetailViewModel(dataStore: FirebaseDataStore(), clientId: clientId))
    }

    var body: some View {
       ScrollView {
             if viewModel.isLoading {
                 ProgressView()
             } else if !viewModel.error.isEmpty {
                 Text("Error: \(viewModel.error)")
             }else {
              if let client = viewModel.client {
                  VStack(alignment: .leading, spacing: 10) {
                       Text("Client Details").font(.headline)
                          VStack(alignment: .leading) {
                             Text("  Client ID: \(client.id)")
                               Text("  Name: \(client.name)")
                              if let email = client.email {
                                  Text("  Email: \(email)")
                              }
                             if let phoneNumber = client.phoneNumber {
                                 Text("  Phone: \(phoneNumber)")
                              }
                             if let address = client.address {
                                  Text("  Address: \(address)")
                               }
                             if let notes = client.notes {
                                 Text("  Notes: \(notes)")
                               }
                             if let tags = client.tags {
                               Text("  Tags: \(tags)")
                           }

                        }


                      }
                  }
            }
       }
    }
}