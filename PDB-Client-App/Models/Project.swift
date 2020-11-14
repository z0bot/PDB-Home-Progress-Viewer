//
//  Project.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import Foundation

struct Project: Identifiable {
    var id = UUID()
    public var builderEmail: String
    public var imageURL: String
    public var name: String
    public var address: String
    public var archived: Bool
    public var rooms: [Room]?
    public var docId: String
    public var changeOrderForms: [ChangeOrderForm]?
    
    //static let `default` = Self(imageURL: "", name: "2020 Bernie St.", address: "2020 Bernie St.")
    
    init(email: String, imageURL: String, name: String, address: String, docId: String) {
        self.builderEmail = email
        self.imageURL = imageURL
        self.name = name
        self.address = address
        self.docId = docId
        self.archived = false
    }
}
