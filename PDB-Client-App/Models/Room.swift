//
//  Room.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/25/20.
//

import Foundation

struct Room: Identifiable {
    var id = UUID()
    var images: [ImageModel]
    var name: String
    
    init(id: UUID, name: String, images: [ImageModel]) {
        self.id = id
        self.name = name
        self.images = images
    }
}
