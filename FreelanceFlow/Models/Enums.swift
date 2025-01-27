//
//  Enums.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation


enum ProjectStatus: String, CaseIterable{
    case pending, inProgress, onHold, completed, cancelled
}
enum MilestoneStatus: String, CaseIterable {
    case pending, inProgress, completed
}

enum TaskPriority: String, CaseIterable {
    case low, normal, high
}

enum TaskStatus: String, CaseIterable {
    case todo, inProgress, completed
}
enum Tab {
    case overview, projects, tasks, clients //, messages
}
