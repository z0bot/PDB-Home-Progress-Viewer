//
//  Project.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import Foundation
import FirebaseUI

struct Project: Identifiable {
    var id = UUID()
    public var imageURL: String
    public var name: String
    public var address: String
    public var archived: Bool
    public var builderEmail: String
    public var docId: String
    public var rooms: [Room]
    public var changeOrderForms: [ChangeOrderForm]
    public var fireForms: FUIArray?
    
    //static let `default` = Self(imageURL: "", name: "2020 Bernie St.", address: "2020 Bernie St.")
    
    init(imageURL: String, name: String, address: String) {
        self.imageURL = imageURL
        self.name = name
        self.address = address
        rooms = []
        archived = false
        changeOrderForms = []
        builderEmail = ""
        docId = ""
        fireForms = nil
    }
    
    init(builderEmail: String, imageURL: String, name: String, address: String, archived: Bool, rooms: [Room], forms: [ChangeOrderForm], docId: String) {
        self.builderEmail = builderEmail
        self.imageURL = imageURL
        self.name = name
        self.address = address
        self.archived = archived
        self.rooms = rooms
        self.docId = docId
        self.changeOrderForms = forms
        fireForms = nil
}
}
