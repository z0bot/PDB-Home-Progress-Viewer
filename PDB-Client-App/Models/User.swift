//
//  User.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//

import Foundation

class User {
    public private(set) var Name: String
    public private(set) var PhoneNumber: String
    public private(set) var EmailAddress: String

    public private(set) var Projects: [Project]
    
    func SendMessage() {
        //TODO: Implement send message functionality
    }
    func AddProject(project: Project) {
        Projects.append(project)
    }
    
    public init(name: String, phoneNumber: String, emailAddress: String) {
        Name = name
        PhoneNumber = phoneNumber
        EmailAddress = emailAddress
        Projects = [Project]()
    }
}
