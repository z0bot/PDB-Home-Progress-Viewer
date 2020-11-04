//
//  MessageView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    var displayName: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if(displayName) {
                Text(message.sender)
                    .foregroundColor(.gray)
                    .font(Font.custom("Microsoft Tai Le", size: 14))
            }
                
            Text(message.text)
                .font(Font.custom("Microsoft Tai Le", size: 20))
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(senderID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, sender: "BC", text: "Hey", date: Date()), displayName: true)
    }
}
