//
//  ImageModel.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import Foundation

struct ImageModel: Identifiable {
    var id: UUID
    var imageURL: String
    var date: Date
    var texty = "This is Text"
    
    func DateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
