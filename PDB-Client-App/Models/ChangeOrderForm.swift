//
//  ChangeOrderForm.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/27/20.
//

import Foundation

struct ChangeOrderForm {
    var title: String
    
    var oldItem: String
    var newItem: String
    
    var oldItemPrice: String
    var newItemPrice: String
    
    var oldPrice: Float
    var newPrice: Float
    
    var description: String
    
    var signed: Bool
    var signatureData: [Float]
}
