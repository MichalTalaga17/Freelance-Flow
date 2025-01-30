//
//  ClientListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ClientsView: View {
    @StateObject var viewModel: ClientListViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingAddClientView = false

        var body: some View {
                ZStack {
                    ClientsListView(viewModel: viewModel)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                isShowingAddClientView.toggle()
                            }) {
                                Text("Add New Client")
                                    .padding()
                                    .background(Color.primary)
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .sheet(isPresented: $isShowingAddClientView) {
                                AddClientView(onSave: { newClient in
                                    viewModel.addClient(newClient)
                                })
                            }
                        }
                    }
                    
                }
        }
    }

#Preview {
    ClientsView(
        viewModel: ClientListViewModel(dataStore: FirebaseDataStore()))
}

