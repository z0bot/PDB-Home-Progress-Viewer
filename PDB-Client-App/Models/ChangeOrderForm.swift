//
//  ChangeOrderForm.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/30/20.
//

import Foundation

struct ChangeOrderForm: Identifiable {
    var id = UUID()
    var fireID: String
    
    var title: String
    var date: Date
    func dateStr() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    
    var initials: String
    var signed: Bool
    var htmlData: String
    
    init(title: String) {
        self.title = title
        fireID = ""
        date = Date()
        htmlData = "<html><body><p>This is an example of a simple HTML page with one paragraph. It comes from a hardcoded variable</p></body> </html>"
        signed = false
        initials = ""
    }
    
    init(fireID: String, title: String, date: Date, htmlData: String, signed: Bool, initials: String) {
        self.fireID = fireID
        self.title = title
        self.date = date
        self.htmlData = htmlData
        self.signed = signed
        self.initials = initials
    }
}
