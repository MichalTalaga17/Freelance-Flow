//
//  AddClientView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 27/01/2025.
//

import SwiftUI

struct AddClientView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var notes: String = ""
    @State private var tags: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Client) -> Void

    private let dataStore = FirebaseDataStore()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client Information")) {
                    TextField("Name", text: $name)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .disableAutocorrection(true)
                    
                    TextField("Address", text: $address)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                }

                Section(header: Text("Additional Details")) {
                    TextField("Notes", text: $notes)
                        .autocapitalization(.sentences)
                    
                    TextField("Tags (comma separated)", text: $tags)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
            }
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss() // Cancel action
                }) {
                    Text("Cancel")
                },
                trailing: Button(action: {
                    saveClient() // Save action
                }) {
                    Text("Save")
                }
            )
            .navigationBarTitle("Add Client", displayMode: .inline)
        }
    }

    private func saveClient() {
        let tagsArray = tags.split(separator: ",").map {
            $0.trimmingCharacters(in: .whitespaces)
        }
        
        let client = Client(
            id: UUID().uuidString,
            name: name,
            email: email.isEmpty ? nil : email,
            phoneNumber: phoneNumber.isEmpty ? nil : phoneNumber,
            address: address.isEmpty ? nil : address,
            notes: notes.isEmpty ? nil : notes,
            tags: tagsArray.isEmpty ? nil : tagsArray
        )
        
        onSave(client)
        presentationMode.wrappedValue.dismiss()
    }
}
