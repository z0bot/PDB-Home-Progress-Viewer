//
//  MessagePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI
import Firebase

struct MessagePage: View {
    @State var ref: DatabaseReference! = nil
    @State var postHandle: DatabaseHandle = 0
    
    var userID: UUID
    var propertyID: UUID
    @State var messages: [Message] = []
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
                }.flippedUpsideDown()
            }.flippedUpsideDown()
            
            
            HStack {
                Image("cameraGray_Icon")
                    .onTapGesture(count: 1, perform: {
                        SendMessage(text: toSend)
                    })
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
        .onAppear {
            ref = Database.database()
                .reference().child("messaging")
                .child("projects")
                .child(propertyID.uuidString)
            
            self.messages = []
            
            postHandle = ref.observe(.childAdded, with: { (snapshot) in
                let messageDict = snapshot.value as? [String: AnyObject]
                // Convert snapshot to value, append to messages
                let message = Message(dictionary: messageDict!)
                
                self.messages.append(message)
                
                self.messages.sort { (Message1, Message2) -> Bool in
                    return Message1.date < Message2.date
                }
                
                
            })
        }
        .onDisappear {
            ref.removeAllObservers()
        }
    }
    
    
    
    init(userID: UUID, propertyID: UUID) {
        self.userID = userID
        self.propertyID = propertyID
        /*ref = Database.database()
            .reference().child("messaging")
            .child("projects")
            .child(propertyID.uuidString)*/
        
        /*self.postHandle = ref.observe(.childAdded, with: { (snapshot) in
            var messageDict = snapshot.value as? [String: AnyObject]
            // Convert snapshot to value, append to messages
            var message = Message(dictionary: messageDict!)
            
            //self.messages.append(message)
        })*/
    }
    
    func SendMessage(text: String) {
        let message = Message(senderID: userID,
                              sender: "Ben",
                              text: text,
                              date: Date())
        
        ref.child(message.id.uuidString).setValue(message.dictionary)
    }
}

struct FlippedUpsideDown: ViewModifier {
   func body(content: Content) -> some View {
    content
        .rotationEffect(.degrees(180))
      .scaleEffect(x: -1, y: 1, anchor: .center)
   }
}
extension View{
   func flippedUpsideDown() -> some View{
     self.modifier(FlippedUpsideDown())
   }
}

struct MessagePage_Previews: PreviewProvider {
    static var previews: some View {
        MessagePage(userID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, propertyID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!)
    }
}
