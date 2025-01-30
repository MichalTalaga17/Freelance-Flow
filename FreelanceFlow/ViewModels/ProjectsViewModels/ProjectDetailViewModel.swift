//
//  ProjectDetailViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

class ProjectDetailViewModel: ObservableObject {
    @Published var project: Project?
    @Published var isLoading: Bool = false
    @Published var error: String = ""

    let dataStore: DataStore
    private let projectId: String

    init(dataStore: DataStore, projectId: String) {
        self.dataStore = dataStore
        self.projectId = projectId
        fetchProject()
    }

    func fetchProject() {
        isLoading = true
        dataStore.fetchProject(id: projectId) { [weak self] project in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let project = project {
                    self?.project = project
                } else {
                    self?.error = "Failed to fetch project with id \(self?.projectId ?? "")"
                }
            }
        }
    }

    func deleteProject(completion: @escaping (Bool) -> Void) {
        isLoading = true
        dataStore.deleteProject(id: projectId) { [weak self] success in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    completion(true)
                } else {
                    self?.error = "Failed to delete project."
                    completion(false)
                }
            }
        }
    }
}
