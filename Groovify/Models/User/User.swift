//
//  User.swift
//  Groovify
//
//  Created by David Romero on 2024-11-19.
//

import Foundation


/// This user model represents the user progamatically. The "MOCKUSER" extension, represents a fake user to be tested in code
struct User: Identifiable, Codable{
    let id: String
    let fullname: String
    let email: String
    //TODO: add more user properties
    
    //returns users name as initals for later display (e.g. Tiger Woods -> TW)
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User{
    //test user
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Daniel Ek", email: "tigerwoods@tigerwoods.com")
}
