//
//  User.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//

import Foundation

class User {
    public private(set) var FirstName: String
    public private(set) var LastName: String
    public private(set) var PhoneNumber: String
    public private(set) var EmailAddress: String
    public private(set) var Projects: [String]
    
    func SendMessage() {
        //TODO: Implement send message functionality
    }
    
    public init(firstname: String, lastname: String, phoneNumber: String, emailAddress: String, projects: [String]) {
        FirstName = firstname
        LastName = lastname
        PhoneNumber = phoneNumber
        EmailAddress = emailAddress
        Projects = projects
    }
}
