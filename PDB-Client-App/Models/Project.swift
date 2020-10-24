//
//  Project.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import Foundation

class Project: ObservableObject {
    public var imageURL: String
    public var name: String
    public var address: String
    public var archived: Bool
    
    
    
    public init(imageURL: String, name: String, address: String) {
        self.imageURL = imageURL
        self.name = name
        self.address = address
        archived = false
    }
}
