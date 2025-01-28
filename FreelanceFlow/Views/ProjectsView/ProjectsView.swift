//
//  ProjectsListView.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject var viewModel: ProjectListViewModel
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingAddProjectView = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                ProjectsListView(viewModel: viewModel)
                
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isShowingAddProjectView.toggle()
                        }) {
                            Text("Add New Project")
                                .padding()
                                .background(Color.primary)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .cornerRadius(8)
                        }
                        .padding()
                        .sheet(isPresented: $isShowingAddProjectView) {
                            AddProjectView(onSave: { newProject in
                                viewModel.addProject(newProject)
                            })
                        }
                    }
                }
            }
            
            
        }
        }
        
}

#Preview {
    ProjectsView(
        viewModel: ProjectListViewModel(dataStore: FirebaseDataStore())
    )
}
