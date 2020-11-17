//
//  MessageView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI
import URLImage

struct MessageView: View {
    var message: Message
    var displayName: Bool
    var colored: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if(displayName) {
                Text(message.sender)
                    .foregroundColor(.gray)
                    .font(Font.custom("Microsoft Tai Le", size: 14))
            }
            
            
            VStack(alignment: .leading) {
                if(message.mediaURL != nil) {
                    URLImage(url: URL(string: message.mediaURL!)!) { image in
                        image.resizable()
                            .scaledToFit()
                    }
                }
                Text(message.text)
                    .font(Font.custom("Microsoft Tai Le", size: 20))
            }.padding()
            .background(colored ? Color.blue : Color.white)
            .cornerRadius(10)
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(senderID: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F", sender: "BC", text: "Hey", date: Date()), displayName: true, colored: true)
    }
}
