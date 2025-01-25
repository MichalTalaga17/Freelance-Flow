//
//  ProjectListViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


// ProjectListViewModel.swift
import Foundation

class ProjectListViewModel : ObservableObject {
    @Published var projects: [Project] = []
     @Published var isLoading: Bool = false
    @Published var error: String = ""
    private let dataStore : DataStore

    init(dataStore: DataStore) {
      self.dataStore = dataStore
        fetchProjects()
    }

    func fetchProjects(){
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
 }

