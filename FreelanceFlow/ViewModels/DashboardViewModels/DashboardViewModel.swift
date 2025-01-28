//
//  DashboardViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 24/01/2025.
//


import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var totalProjects: String = "0"
    @Published var activeProjects: String = "0"
    @Published var completedProjects: String = "0"
    @Published var totalTasks: String = "0"
    @Published var openTasks: String = "0"
    @Published var completedTasks: String = "0"

    @Published var isLoading = false
    @Published var error: String?

    private let dataStore: DataStore

    init(dataStore: DataStore) {
        self.dataStore = dataStore
    }

   @MainActor
    func fetchStats() async {
       isLoading = true
       error = nil
         
       defer { isLoading = false }

         do {
             print("fetching projects async")
            let projects = try await fetchProjectsAsync()
             print("fetching tasks async")
            let tasks = try await fetchTasksAsync()
             
             totalProjects = String(projects.count)
             activeProjects = String(projects.filter { $0.status == .inProgress }.count)
             completedProjects = String(projects.filter { $0.status == .completed }.count)
             totalTasks = String(tasks.count)
            openTasks = String(tasks.filter { $0.status != .completed }.count)
             completedTasks = String(tasks.filter { $0.status == .completed }.count)
            
         } catch {
              self.error = error.localizedDescription
         }
     }

    private func fetchProjectsAsync() async throws -> [Project] {
        return try await withCheckedThrowingContinuation { continuation in
            dataStore.fetchProjects { projects in
                if let projects = projects {
                    continuation.resume(returning: projects)
                } else {
                     continuation.resume(throwing: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to fetch projects"]))
                }
            }
        }
    }

    private func fetchTasksAsync() async throws -> [ProjectTask] {
        return try await withCheckedThrowingContinuation { continuation in
            dataStore.fetchTasks { tasks in
                if let tasks = tasks {
                   continuation.resume(returning: tasks)
               } else {
                   continuation.resume(throwing: NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to fetch tasks"]))
                }
           }
        }
    }
}
