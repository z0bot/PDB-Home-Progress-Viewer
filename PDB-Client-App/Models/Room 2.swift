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
}
