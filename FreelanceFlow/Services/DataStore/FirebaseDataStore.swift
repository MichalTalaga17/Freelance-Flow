//
//  FirebaseDataStore.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Firebase
import FirebaseDatabase

class FirebaseDataStore: DataStore {

    private let database = Database.database().reference()

    // MARK: - Project Operations

    func fetchProjects(completion: @escaping ([Project]?) -> Void) {
        print("FirebaseDataStore: fetchProjects() called")
        database.child("projects").observeSingleEvent(of: .value) { snapshot in
             print("FirebaseDataStore: fetchProjects - observeSingleEvent triggered, snapshot \(snapshot.childrenCount)")
            guard let value = snapshot.value as? [String: Any] else {
                  print("FirebaseDataStore: fetchProjects - guard failed, value is not [String:Any]")
                completion(nil)
                return
            }
            let projects = value.compactMap { (key, value) -> Project? in
                 print("FirebaseDataStore: fetchProjects - mapping a project")
                guard let value = value as? [String: Any] else {
                   print("FirebaseDataStore: fetchProjects - guard failed while mapping project")
                    return nil
                }
               return self.createProjectFromFirebaseData(key: key, value: value)
            }
            print("FirebaseDataStore: fetchProjects - completion called, projects count: \(projects.count)")
            completion(projects)
        }
    }

    func fetchProject(id: String, completion: @escaping (Project?) -> Void) {
         print("FirebaseDataStore: fetchProject() called with id \(id)")
        database.child("projects").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                  print("FirebaseDataStore: fetchProject() - guard failed, value is not [String:Any] for id \(id)")
                completion(nil)
                return
            }
            let project =  self.createProjectFromFirebaseData(key: snapshot.key, value: value)
            print("FirebaseDataStore: fetchProject() - completion called for id: \(id)")
            completion(project)
        }
    }

     func saveProject(project: Project, completion: @escaping (Bool) -> Void) {
         print("FirebaseDataStore: saveProject() called with id \(project.id)")
        let projectData = project.toDictionary()
        database.child("projects").child(project.id).setValue(projectData) { error, _ in
             if let error = error {
                  print("FirebaseDataStore: saveProject() -  error: \(error)")
               } else {
                  print("FirebaseDataStore: saveProject() - successfully saved project: \(project.id)")
             }
            completion(error == nil)
        }
    }

    func deleteProject(id: String, completion: @escaping (Bool) -> Void) {
        print("FirebaseDataStore: deleteProject() called with id \(id)")
        database.child("projects").child(id).removeValue { error, _ in
             if let error = error {
                  print("FirebaseDataStore: deleteProject() - error: \(error)")
               } else {
                  print("FirebaseDataStore: deleteProject() - successfully deleted project: \(id)")
               }
            completion(error == nil)
        }
    }

    // MARK: - Client Operations

    func fetchClients(completion: @escaping ([Client]?) -> Void) {
         print("FirebaseDataStore: fetchClients() called")
        database.child("clients").observeSingleEvent(of: .value) { snapshot in
           print("FirebaseDataStore: fetchClients - observeSingleEvent triggered, snapshot \(snapshot.childrenCount)")
             guard let value = snapshot.value as? [String: Any] else {
                   print("FirebaseDataStore: fetchClients - guard failed, value is not [String:Any]")
                completion(nil)
                return
            }
            let clients = value.compactMap { (key, value) -> Client? in
                 print("FirebaseDataStore: fetchClients - mapping a client")
                guard let value = value as? [String: Any] else {
                  print("FirebaseDataStore: fetchClients - guard failed while mapping client")
                    return nil
                }
               return self.createClientFromFirebaseData(key: key, value: value)
            }
            print("FirebaseDataStore: fetchClients - completion called, clients count: \(clients.count)")
            completion(clients)
        }
    }

    func fetchClient(id: String, completion: @escaping (Client?) -> Void) {
         print("FirebaseDataStore: fetchClient() called with id \(id)")
        database.child("clients").child(id).observeSingleEvent(of: .value) { snapshot in
             guard let value = snapshot.value as? [String: Any] else {
                print("FirebaseDataStore: fetchClient() - guard failed, value is not [String:Any] for id \(id)")
                completion(nil)
                return
            }
           let client = self.createClientFromFirebaseData(key: snapshot.key, value: value)
            print("FirebaseDataStore: fetchClient() - completion called for id: \(id)")
            completion(client)
        }
    }

    func saveClient(client: Client, completion: @escaping (Bool) -> Void) {
         print("FirebaseDataStore: saveClient() called with id \(client.id)")
        let clientData = client.toDictionary()
        database.child("clients").child(client.id).setValue(clientData) { error, _ in
            if let error = error {
                  print("FirebaseDataStore: saveClient() - error: \(error)")
             } else {
                print("FirebaseDataStore: saveClient() - successfully saved client: \(client.id)")
            }
            completion(error == nil)
        }
    }

    func deleteClient(id: String, completion: @escaping (Bool) -> Void) {
          print("FirebaseDataStore: deleteClient() called with id \(id)")
        database.child("clients").child(id).removeValue { error, _ in
           if let error = error {
               print("FirebaseDataStore: deleteClient() - error: \(error)")
            } else {
                print("FirebaseDataStore: deleteClient() - successfully deleted client: \(id)")
            }
            completion(error == nil)
        }
    }

    // MARK: - Task Operations

    func fetchTasks(completion: @escaping ([ProjectTask]?) -> Void) {
        print("FirebaseDataStore: fetchTasks() called")
        database.child("tasks").observeSingleEvent(of: .value) { snapshot in
             print("FirebaseDataStore: fetchTasks - observeSingleEvent triggered, snapshot \(snapshot.childrenCount)")
            guard let value = snapshot.value as? [String: Any] else {
                print("FirebaseDataStore: fetchTasks - guard failed, value is not [String:Any]")
                completion(nil)
                return
            }
            let tasks = value.compactMap { (key, value) -> ProjectTask? in
                 print("FirebaseDataStore: fetchTasks - mapping a task")
                guard let value = value as? [String: Any] else {
                  print("FirebaseDataStore: fetchTasks - guard failed while mapping task")
                    return nil
                }
                return self.createTaskFromFirebaseData(key: key, value: value)
            }
             print("FirebaseDataStore: fetchTasks - completion called, tasks count: \(tasks.count)")
            completion(tasks)
        }
    }

    func fetchTask(id: String, completion: @escaping (ProjectTask?) -> Void) {
         print("FirebaseDataStore: fetchTask() called with id \(id)")
        database.child("tasks").child(id).observeSingleEvent(of: .value) { snapshot  in
             guard let value = snapshot.value as? [String: Any] else {
                print("FirebaseDataStore: fetchTask() - guard failed, value is not [String:Any] for id \(id)")
                completion(nil)
                return
           }
           let task = self.createTaskFromFirebaseData(key: snapshot.key, value: value)
            print("FirebaseDataStore: fetchTask() - completion called for id: \(id)")
            completion(task)
       }
   }

    func saveTask(task: ProjectTask, completion: @escaping (Bool) -> Void) {
        print("FirebaseDataStore: saveTask() called with id \(task.id)")
        let taskData = task.toDictionary()
        database.child("tasks").child(task.id).setValue(taskData) { error, _ in
            if let error = error {
               print("FirebaseDataStore: saveTask() - error: \(error)")
             } else {
                print("FirebaseDataStore: saveTask() - successfully saved task: \(task.id)")
            }
            completion(error == nil)
        }
    }

   func deleteTask(id: String, completion: @escaping (Bool) -> Void) {
          print("FirebaseDataStore: deleteTask() called with id \(id)")
        database.child("tasks").child(id).removeValue { error, _ in
              if let error = error {
                    print("FirebaseDataStore: deleteTask() - error: \(error)")
               } else {
                print("FirebaseDataStore: deleteTask() - successfully deleted task: \(id)")
            }
            completion(error == nil)
        }
    }
    private func createProjectFromFirebaseData(key:String, value: [String: Any]) -> Project? {
            guard let name = value["name"] as? String,
                  let statusString = value["status"] as? String,
                  let status = ProjectStatus(rawValue: statusString)

            else {
                print("FirebaseDataStore: createProjectFromFirebaseData - guard failed")
                return nil
            }
            var deadline : Date? = nil
            if let deadlineTimestamp = value["deadline"] as? TimeInterval {
                deadline = Date(timeIntervalSince1970: deadlineTimestamp)
            }

            return Project(id: key,
                           name: name,
                           description: value["description"] as? String,
                           deadline: deadline,
                           status: status,
                           clientId: value["clientId"] as? String,
                            goals: value["goals"] as? [String],
                            milestones: (value["milestones"] as? [[String: Any]])?.compactMap { self.createMilestoneFromFirebaseData(dictionary: $0)},
                            budget: value["budget"] as? Double,
                            actualCost: value["actualCost"] as? Double,
                            tags: value["tags"] as? [String],
                           progress: value["progress"] as? Double)
       }

    private func createMilestoneFromFirebaseData(dictionary: [String: Any]) -> Milestone? {
         guard let name = dictionary["name"] as? String,
               let statusString = dictionary["status"] as? String,
               let status = MilestoneStatus(rawValue: statusString)

         else {
               print("FirebaseDataStore: createMilestoneFromFirebaseData - guard failed")
                return nil
        }
            var deadline : Date? = nil
            if let deadlineTimestamp = dictionary["deadline"] as? TimeInterval {
                deadline = Date(timeIntervalSince1970: deadlineTimestamp)
           }
        
             return Milestone(id: dictionary["id"] as? String ?? UUID().uuidString,
                             name: name,
                             description: dictionary["description"] as? String,
                             deadline: deadline,
                             status: status)
    }

    private func createClientFromFirebaseData(key:String, value: [String: Any]) -> Client?{
          guard let name = value["name"] as? String
             else {
                print("FirebaseDataStore: createClientFromFirebaseData - guard failed")
               return nil
            }
           return  Client(id: key,
                           name: name,
                           email: value["email"] as? String,
                           phoneNumber: value["phoneNumber"] as? String,
                           address: value["address"] as? String,
                           notes: value["notes"] as? String,
                           tags: value["tags"] as? [String])
    }

    private func createTaskFromFirebaseData(key:String, value: [String: Any]) -> ProjectTask? {
         guard let projectId = value["projectId"] as? String,
                let name = value["name"] as? String,
               let statusString = value["status"] as? String,
                let priorityString = value["priority"] as? String,
                let status = TaskStatus(rawValue: statusString),
                 let priority = TaskPriority(rawValue: priorityString)
             else {
                print("FirebaseDataStore: createTaskFromFirebaseData - guard failed")
                 return nil
             }
        var deadline : Date? = nil
         if let deadlineTimestamp = value["deadline"] as? TimeInterval {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        }
         var startTime : Date? = nil
        if let startTimeTimestamp = value["startTime"] as? TimeInterval {
           startTime =  Date(timeIntervalSince1970: startTimeTimestamp)
        }
          return ProjectTask(id: key,
                       projectId: projectId,
                       name: name,
                       description: value["description"] as? String,
                       status: status,
                       priority: priority,
                        deadline: deadline,
                       startTime: startTime,
                       estimatedTime: value["estimatedTime"] as? TimeInterval,
                       comments: (value["comments"] as? [[String: Any]])?.compactMap { self.createCommentFromFirebaseData(dictionary: $0) })

  }

   private func createCommentFromFirebaseData(dictionary: [String: Any]) -> Comment? {
            guard let authorId = dictionary["authorId"] as? String,
                  let dateTimestamp = dictionary["date"] as? TimeInterval,
                  let text = dictionary["text"] as? String
            else {
                 print("FirebaseDataStore: createCommentFromFirebaseData - guard failed")
                return nil
            }
        return Comment(id: dictionary["id"] as? String ?? UUID().uuidString,
                         authorId: authorId,
                        date: Date(timeIntervalSince1970: dateTimestamp),
                         text: text)
   }
}
