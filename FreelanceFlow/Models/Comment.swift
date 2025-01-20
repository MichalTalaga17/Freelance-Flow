//
//  Comment.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation
struct Comment {
    let id: String
    var authorId: String
    var date: Date
    var text: String
    
    init(id: String, authorId: String, date: Date, text: String) {
        self.id = id
        self.authorId = authorId
        self.date = date
        self.text = text
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "authorId": authorId,
            "date": date.timeIntervalSince1970,
            "text": text
        ]
    }
}
