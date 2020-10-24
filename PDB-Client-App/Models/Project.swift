//
//  Project.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import Foundation

struct Project: Identifiable {
    var id = UUID()
    public var imageURL: String
    public var name: String
    public var address: String
    public var archived: Bool
    
    static let `default` = Self(imageURL: "", name: "2020 Bernie St.", address: "2020 Bernie St.")
    
    init(imageURL: String, name: String, address: String) {
        self.imageURL = imageURL
        self.name = name
        self.address = address
        archived = false
    }
}
