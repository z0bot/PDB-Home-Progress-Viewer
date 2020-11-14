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
    var mediaURL: String? = nil
    var dictionary: [String: Any] {
        if(mediaURL == nil) {
            return [
                "senderID": senderID.uuidString,
                "sender": sender,
                "text": text,
                "date": date.ToString()
            ]
        }
        else {
            return [
                "senderID": senderID.uuidString,
                "sender": sender,
                "text": text,
                "date": date.ToString(),
                "mediaURL": mediaURL!
            ]
        }
    }
    
    init(senderID: UUID, sender: String, text: String, date: Date, mediaURL: String? = nil) {
        self.sender = sender
        self.senderID = senderID
        self.text = text
        self.date = date
        self.mediaURL = mediaURL
    }
    
    init(dictionary: [String : AnyObject]) {
        let idStr = dictionary["senderID"] as! String
        self.senderID = UUID.init(uuidString: idStr)!
        self.sender = dictionary["sender"] as! String
        self.text = dictionary["text"] as! String
        let dateStr = dictionary["date"] as! String
        
        let mediaURL = dictionary["mediaURL"] as? String
        
        if(mediaURL != nil) {
            self.mediaURL = mediaURL!
        }
        
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
