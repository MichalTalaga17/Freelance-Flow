//
//  Milestone.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation

struct Milestone {
    let id: String
    var name: String
    var description: String?
    var deadline: Date?
    var status: MilestoneStatus
    
    init(id: String, name: String, description: String? = nil, deadline: Date? = nil, status: MilestoneStatus) {
        self.id = id
        self.name = name
        self.description = description
        self.deadline = deadline
        self.status = status
    }
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "id": id,
            "name": name,
            "status": status.rawValue
        ]
        if let description = description { dict["description"] = description }
        if let deadline = deadline { dict["deadline"] = deadline.timeIntervalSince1970 }
        return dict
    }
    
}
