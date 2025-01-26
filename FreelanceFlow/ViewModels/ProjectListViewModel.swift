//
//  ProjectListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation

class ProjectListViewModel: ObservableObject {
    @Published var projects: [Project] = []
    @Published var isLoading: Bool = false
    @Published var error: String = ""
    
    private let dataStore: DataStore
    

    init(dataStore: DataStore) {
        self.dataStore = dataStore
        fetchProjects()
    }

    func fetchProjects() {
        isLoading = true
        dataStore.fetchProjects { [weak self] projects in
            self?.isLoading = false
            if let projects = projects {
                self?.projects = projects
            } else {
                self?.error = "Failed to fetch projects"
            }
        }
    }
    
    func addProject(_ project: Project) {
        dataStore.saveProject(project: project) { [weak self] success in
            if success {
                self?.projects.append(project)
            } else {
                self?.error = "Failed to save the project"
            }
        }
    }
}


