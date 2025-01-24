//
//  DataStore.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


import Foundation

protocol DataStore {
    // MARK: - Project Operations
    func fetchProjects(completion: @escaping ([Project]?) -> Void)
    func fetchProject(id: String, completion: @escaping (Project?) -> Void)
    func saveProject(project: Project, completion: @escaping (Bool) -> Void)
    func deleteProject(id: String, completion: @escaping (Bool) -> Void)

    // MARK: - Client Operations
    func fetchClients(completion: @escaping ([Client]?) -> Void)
    func fetchClient(id: String, completion: @escaping (Client?) -> Void)
    func saveClient(client: Client, completion: @escaping (Bool) -> Void)
    func deleteClient(id: String, completion: @escaping (Bool) -> Void)

    // MARK: - Task Operations
    func fetchTasks(completion: @escaping ([Task]?) -> Void)
    func fetchTask(id: String, completion: @escaping (Task?) -> Void)
    func saveTask(task: Task, completion: @escaping (Bool) -> Void)
    func deleteTask(id: String, completion: @escaping (Bool) -> Void)
}
