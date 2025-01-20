//
//  ContentViewModel.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import SwiftUI

class ContentViewModel : ObservableObject {
    @Published var projects: [Project] = []
    @Published var clients: [Client] = []
    @Published var tasks: [Task] = []
    @Published var isLoading: Bool = false
    @Published var error: String = ""

    private let dataStore : DataStore

    init(dataStore: DataStore) {
        self.dataStore = dataStore
        fetchData()
    }

    func fetchData(){
        print("ContentViewModel: fetchData() called")
        isLoading = true
        error = ""
        let group = DispatchGroup()

        group.enter()
        dataStore.fetchProjects { [weak self] projects in
              print("ContentViewModel: fetchProjects completion called")
             self?.isLoading = false
             if let projects = projects {
                  print("ContentViewModel: fetchProjects success, \(projects.count) projects")
                   self?.projects = projects
               } else {
                   print("ContentViewModel: fetchProjects failed")
                   self?.error = "Failed to fetch projects"
               }
              group.leave()
           }
       group.enter()
       dataStore.fetchClients { [weak self] clients in
           print("ContentViewModel: fetchClients completion called")
          self?.isLoading = false
          if let clients = clients {
                 print("ContentViewModel: fetchClients success, \(clients.count) clients")
                  self?.clients = clients
              } else {
                  print("ContentViewModel: fetchClients failed")
                  self?.error =  "Failed to fetch clients"
              }
          group.leave()

      }
       group.enter()
       dataStore.fetchTasks { [weak self] tasks in
           print("ContentViewModel: fetchTasks completion called")
          self?.isLoading = false
          if let tasks = tasks {
               print("ContentViewModel: fetchTasks success, \(tasks.count) tasks")
                  self?.tasks = tasks
            } else {
                print("ContentViewModel: fetchTasks failed")
                self?.error = "Failed to fetch tasks"
           }
           group.leave()
       }
       group.notify(queue: .main) {
            print("ContentViewModel: notify on main queue")
         self.isLoading = false
       }

   }
}
