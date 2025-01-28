//
//  Task.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation
struct ProjectTask {
    let id: String
    var projectId: String
    var name: String
    var description: String?
    var status: TaskStatus
    var priority: TaskPriority
    var deadline: Date?
    var startTime: Date?
    var estimatedTime: TimeInterval?
    var comments: [Comment]?
    
    init(id: String, projectId: String, name: String, description: String? = nil, status: TaskStatus, priority: TaskPriority, deadline: Date? = nil, startTime: Date? = nil, estimatedTime: TimeInterval? = nil, comments: [Comment]? = nil) {
        self.id = id
        self.projectId = projectId
        self.name = name
        self.description = description
        self.status = status
        self.priority = priority
        self.deadline = deadline
        self.startTime = startTime
        self.estimatedTime = estimatedTime
        self.comments = comments
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "projectId": projectId,
            "name": name,
            "status": status.rawValue,
            "priority": priority.rawValue
        ]
        if let description = description { dict["description"] = description }
        if let deadline = deadline {dict["deadline"] = deadline.timeIntervalSince1970 }
        if let startTime = startTime { dict["startTime"] = startTime.timeIntervalSince1970 }
        if let estimatedTime = estimatedTime { dict["estimatedTime"] = estimatedTime }
        if let comments = comments {
            dict["comments"] = comments.map{$0.toDictionary()}
        }
        return dict
    }
}
