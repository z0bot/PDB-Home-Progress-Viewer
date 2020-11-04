//
//  MessagePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI

struct MessagePage: View {
    var userID: UUID
    var messages: [Message]
    @State var toSend: String = ""
    
    var body: some View {
        
        VStack {
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(messages) { message in
                        HStack {
                            if(message.senderID == userID) {
                                Spacer()
                                MessageView(message: message, displayName: false)
                                    .padding()
                            }
                            else {
                                MessageView(message: message, displayName: true)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                }
            }
            
            
            HStack {
                Image("cameraGray_Icon")
                TextField("Send Message", text: $toSend)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }.padding()
        }.background(Color("backgroundColor"))
    }
}

struct MessagePage_Previews: PreviewProvider {
    static var previews: some View {
        MessagePage(userID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, messages: [Message(senderID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, sender: "BC", text: "Hey", date: Date()), Message(senderID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5E")!, sender: "BC", text: "Hey 2 u", date: Date())])
    }
}
