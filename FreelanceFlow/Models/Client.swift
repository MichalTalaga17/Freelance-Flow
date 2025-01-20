//
//  Client.swift
//  FreelanceFlow
//
//  Created by Michał Talaga on 20/01/2025.
//

import Foundation

struct Client {
    let id: String
    var name: String
    var email: String?
    var phoneNumber: String?
    var address: String?
    var notes: String?
    var tags: [String]?
    
    init(id: String, name: String, email: String? = nil, phoneNumber: String? = nil, address: String? = nil, notes: String? = nil, tags: [String]? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.notes = notes
        self.tags = tags
    }
    
    
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [
            "name": name,
        ]
        if let email = email { dict["email"] = email }
        if let phoneNumber = phoneNumber {dict["phoneNumber"] = phoneNumber}
        if let address = address {dict["address"] = address}
        if let notes = notes { dict["notes"] = notes}
        if let tags = tags { dict["tags"] = tags}
        return dict
    }
}
