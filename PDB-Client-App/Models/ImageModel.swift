//
//  ImageModel.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import Foundation
import UIKit

struct ImageModel: Identifiable {
    var id: UUID
    var imageURL: String
    var date: Date
    var is360: Bool
    var texty = "This is Text"
    
    func getImage() -> UIImage {
        let url = URL(string: self.imageURL)!
        let imageData = try! Data(contentsOf: url)
        
        let image = UIImage(data: imageData)
        
        return image!
    }
    
    func DateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
