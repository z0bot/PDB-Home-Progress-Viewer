//
//  ChangeOrderForm.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/30/20.
//

import Foundation

struct ChangeOrderForm: Identifiable {
    var id = UUID()
    
    var title: String
    var description: String
    var date: Date
    
    func dateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
    
    static func FloatToDollars(num: Float) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: num))!
    }
    
    var oldItem: String
    var newItem: String
    
    var oldItemPrice: Float
    var newItemPrice: Float
    
    var oldTotalCost: Float
    var newTotalCost: Float
    
    var signed: Bool
    var sigData: [Float]
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        date = Date()
        oldItem = "OldItem"
        newItem = "NewItem"
        oldItemPrice = 0
        newItemPrice = 1
        oldTotalCost = 1
        newTotalCost = 1
        
        signed = false
        sigData = []
    }
    
    init(title: String, description: String, date: Date, oldItem: String, newItem: String, oldItemPrice: Float, newItemPrice: Float, oldTotal: Float, newTotal: Float) {
        self.title = title
        self.description = description
        self.date = date
        self.oldItem = oldItem
        self.newItem = newItem
        self.oldItemPrice = oldItemPrice
        self.newItemPrice = newItemPrice
        self.oldTotalCost = oldTotal
        self.newTotalCost = newTotal
        
        signed = false
        sigData = []
    }
}
