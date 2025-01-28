//
//  ProjectDetailViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


// ProjectDetailViewModel.swift
import Foundation

class ProjectDetailViewModel : ObservableObject {
     @Published var project: Project?
     @Published var isLoading: Bool = false
    @Published var error: String = ""

    private let dataStore : DataStore
    private let projectId: String

    init(dataStore: DataStore, projectId: String) {
        self.dataStore = dataStore
        self.projectId = projectId
        fetchProject()
    }

    func fetchProject(){
           isLoading = true
           dataStore.fetchProject(id: projectId) { [weak self] project in
              self?.isLoading = false
             if let project = project {
                   self?.project = project
               } else {
                   self?.error = "Failed to fetch project with id \(self?.projectId ?? "")"
              }
          }
    }
 }