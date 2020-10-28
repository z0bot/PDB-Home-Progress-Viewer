//
//  ImageModel.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import Foundation

struct ImageModel: Identifiable {
    var id = UUID()
    var imageData: String
    var date: Date
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
