//
//  FirebaseDataStore.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//


// FirebaseDataStore.swift

import Firebase
import FirebaseDatabase

class FirebaseDataStore: DataStore {

    private let database = Database.database().reference()

    // MARK: - Project Operations

    func fetchProjects(completion: @escaping ([Project]?) -> Void) {
        database.child("projects").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let projects = value.compactMap { (key, value) -> Project? in
                guard let value = value as? [String: Any] else {
                    return nil
                }
              
                return self.createProjectFromFirebaseData(key: key, value: value)
            }
            completion(projects)
        }
    }

    func fetchProject(id: String, completion: @escaping (Project?) -> Void) {
        database.child("projects").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let project =  self.createProjectFromFirebaseData(key: snapshot.key, value: value)
            completion(project)
        }
    }

     func saveProject(project: Project, completion: @escaping (Bool) -> Void) {
        let projectData = project.toDictionary()
        database.child("projects").child(project.id).setValue(projectData) { error, _ in
            completion(error == nil)
        }
    }

    func deleteProject(id: String, completion: @escaping (Bool) -> Void) {
        database.child("projects").child(id).removeValue { error, _ in
           completion(error == nil)
       }
   }

    // MARK: - Client Operations

    func fetchClients(completion: @escaping ([Client]?) -> Void) {
        database.child("clients").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let clients = value.compactMap { (key, value) -> Client? in
                guard let value = value as? [String: Any] else {
                    return nil
                }
                  return self.createClientFromFirebaseData(key: key, value: value)
            }
            completion(clients)
        }
    }

    func fetchClient(id: String, completion: @escaping (Client?) -> Void) {
        database.child("clients").child(id).observeSingleEvent(of: .value) { snapshot in
             guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
             }
            let client = self.createClientFromFirebaseData(key: snapshot.key, value: value)
            completion(client)
        }
    }

     func saveClient(client: Client, completion: @escaping (Bool) -> Void) {
        let clientData = client.toDictionary()
        database.child("clients").child(client.id).setValue(clientData) { error, _ in
            completion(error == nil)
        }
    }


    func deleteClient(id: String, completion: @escaping (Bool) -> Void) {
        database.child("clients").child(id).removeValue { error, _ in
            completion(error == nil)
        }
    }

    // MARK: - Task Operations

    func fetchTasks(completion: @escaping ([Task]?) -> Void) {
        database.child("tasks").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let tasks = value.compactMap { (key, value) -> Task? in
                guard let value = value as? [String: Any] else {
                    return nil
                }
                return self.createTaskFromFirebaseData(key: key, value: value)
            }
            completion(tasks)
        }
    }

    func fetchTask(id: String, completion: @escaping (Task?) -> Void) {
        database.child("tasks").child(id).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(nil)
                return
            }
            let task = self.createTaskFromFirebaseData(key: snapshot.key, value: value)
            completion(task)
       }
   }

    func saveTask(task: Task, completion: @escaping (Bool) -> Void) {
        let taskData = task.toDictionary()
        database.child("tasks").child(task.id).setValue(taskData) { error, _ in
            completion(error == nil)
        }
    }

   func deleteTask(id: String, completion: @escaping (Bool) -> Void) {
        database.child("tasks").child(id).removeValue { error, _ in
            completion(error == nil)
        }
    }

     private func createProjectFromFirebaseData(key:String, value: [String: Any]) -> Project? {
           guard let name = value["name"] as? String,
                 let statusString = value["status"] as? String,
                 let status = ProjectStatus(rawValue: statusString)

            else {
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

      private func createTaskFromFirebaseData(key:String, value: [String: Any]) -> Task? {
          guard let projectId = value["projectId"] as? String,
                 let name = value["name"] as? String,
                 let statusString = value["status"] as? String,
                 let priorityString = value["priority"] as? String,
                 let status = TaskStatus(rawValue: statusString),
                 let priority = TaskPriority(rawValue: priorityString)
            else {
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
            return Task(id: key,
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
               return nil
           }
          return Comment(id: dictionary["id"] as? String ?? UUID().uuidString,
                         authorId: authorId,
                          date: Date(timeIntervalSince1970: dateTimestamp),
                         text: text)
      }

}
