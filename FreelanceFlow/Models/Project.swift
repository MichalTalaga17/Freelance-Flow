//
//  Project.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation

struct Project: Identifiable {
    let id: String
    var name: String
    var description: String?
    var deadline: Date?
    var status: ProjectStatus
    var clientId: String?
    var goals: [String]?
    var milestones: [Milestone]?
    var budget: Double?
    var actualCost: Double?
    var tags: [String]?
    var progress: Double?
    
    init(id: String, name: String, description: String? = nil, deadline: Date? = nil, status: ProjectStatus, clientId: String? = nil, goals: [String]? = nil, milestones: [Milestone]? = nil, budget: Double? = nil, actualCost: Double? = nil, tags: [String]? = nil, progress: Double? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.deadline = deadline
        self.status = status
        self.clientId = clientId
        self.goals = goals
        self.milestones = milestones
        self.budget = budget
        self.actualCost = actualCost
        self.tags = tags
        self.progress = progress
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "name": name,
            "status": status.rawValue
        ]
        if let description = description { dict["description"] = description }
        if let deadline = deadline { dict["deadline"] = deadline.timeIntervalSince1970 }
        if let clientId = clientId { dict["clientId"] = clientId }
        if let goals = goals {dict["goals"] = goals }
        if let milestones = milestones {
            dict["milestones"] = milestones.map {$0.toDictionary()}
        }
        
        if let budget = budget { dict["budget"] = budget }
        if let actualCost = actualCost { dict["actualCost"] = actualCost }
        if let tags = tags { dict["tags"] = tags}
        if let progress = progress { dict["progress"] = progress}
        return dict
    }
}
