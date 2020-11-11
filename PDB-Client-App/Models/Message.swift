//
//  Message.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import Foundation
import Firebase

struct Message: Identifiable {
    var id = UUID()
    var senderID: UUID
    var sender: String
    var text: String
    var date: Date
    var dictionary: [String: Any] {
        return [
            "senderID": senderID.uuidString,
            "sender": sender,
            "text": text,
            "date": date.ToString()
        ]
    }
    
    init(senderID: UUID, sender: String, text: String, date: Date) {
        self.sender = sender
        self.senderID = senderID
        self.text = text
        self.date = date
    }
    
    init(dictionary: [String : AnyObject]) {
        let idStr = dictionary["senderID"] as! String
        self.senderID = UUID.init(uuidString: idStr)!
        self.sender = dictionary["sender"] as! String
        self.text = dictionary["text"] as! String
        let dateStr = dictionary["date"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.date = dateFormatter.date(from: dateStr)!
    }
    
    init(dataSnap: DataSnapshot) {
        let idStr = dataSnap.value(forKey: "senderID") as! String
        self.senderID = UUID(uuidString: idStr)!
        self.sender = dataSnap.value(forKey: "SenderName") as! String
        self.text = dataSnap.value(forKey: "Message") as! String
        let dateStr = dataSnap.value(forKey: "date") as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        self.date = dateFormatter.date(from: dateStr)!
    }
}

extension Date {
    func ToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    static func String(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.date(from: from)!
    }
}
