//
//  Message.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import Foundation

struct Message: Identifiable {
    var id = UUID()
    var senderID: UUID
    var sender: String
    var text: String
    var date: Date
}
