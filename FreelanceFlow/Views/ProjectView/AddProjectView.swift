//
//  AddProjectView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 26/01/2025.
//

import SwiftUI

struct AddProjectView: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var status: ProjectStatus = .pending
    @State private var budget: String = ""
    @State private var deadline: Date = Date()
    @State private var tags: String = ""
    @State private var selectedClient: Client? = nil
    @State private var clients: [Client] = []
    @State private var isLoadingClients = true
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Project) -> Void

    private let dataStore = FirebaseDataStore()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Project Information")) {
                    TextField("Project Name", text: $name)
                        .autocapitalization(.words)
                    
                    TextField("Description", text: $description)
                        .autocapitalization(.sentences)
                    
                    Picker("Status", selection: $status) {
                        ForEach(ProjectStatus.allCases, id: \.self) { status in
                            Text(status.rawValue.capitalized).tag(status)
                        }
                    }
                }

                Section(header: Text("Client")) {
                    if isLoadingClients {
                        Text("Loading clients...")
                    } else {
                        Picker("Select Client", selection: $selectedClient) {
                            Text("None").tag(Client?.none)
                            ForEach(clients, id: \.id) { client in
                                Text(client.name).tag(client as Client?)
                            }
                        }
                    }
                }

                Section(header: Text("Financial Details")) {
                    TextField("Budget", text: $budget)
                        .keyboardType(.decimalPad)
                        .padding(.vertical, 5)
                }

                Section(header: Text("Deadline")) {
                    DatePicker(
                        "Deadline",
                        selection: $deadline,
                        displayedComponents: .date
                    )
                }

                Section(header: Text("Tags")) {
                    TextField("Tags (comma separated)", text: $tags)
                        .autocapitalization(.none)
                }

            }
            .navigationBarItems(
                            leading: Button(action: {
                                presentationMode.wrappedValue.dismiss() // Anulowanie
                            }) {
                                Text("Cancel")
                            },
                            trailing: Button(action: {
                                saveProject() // Zapisanie projektu
                            }) {
                                Text("Save")
                            }
                        )
            .navigationBarTitle("Add Project", displayMode: .inline)
            .onAppear {
                loadClients()
            }
        }
    }

    private func loadClients() {
        dataStore.fetchClients { fetchedClients in
            self.clients = fetchedClients ?? []
            self.isLoadingClients = false
        }
    }

    private func saveProject() {
        let budgetValue = Double(budget) ?? 0.0
        let tagsArray = tags.split(separator: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        
        let project = Project(
            id: UUID().uuidString,
            name: name,
            description: description.isEmpty ? nil : description,
            deadline: deadline,
            status: status,
            clientId: selectedClient?.id,
            budget: budgetValue,
            tags: tagsArray // Assign selected client
        )
        
        onSave(project)
        presentationMode.wrappedValue.dismiss()
    }
}
