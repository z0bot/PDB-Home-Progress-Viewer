//
//  MessagePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct MessagePage: View {
    @State var ref: DatabaseReference! = nil
    @State var postHandle: DatabaseHandle = 0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var userID: UUID
    var propertyID: UUID
    @State var messages: [Message] = []
    @State var toSend: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer()
                    ForEach(messages.indices) { messageInd in
                        HStack {
                            if(messageInd < messages.count && messageInd >= 0) {
                                if(messages[messageInd].senderID == userID) {
                                    Spacer()
                                    MessageView(message: messages[messageInd], displayName: false, colored: true)
                                        .padding([.leading, .trailing])
                                }
                                else {
                                    // Do not display name if previous message came from same sender
                                    if(messageInd > 0 && messages[messageInd - 1].senderID == messages[messageInd].senderID) {
                                        MessageView(message: messages[messageInd], displayName: false)
                                            .padding([.leading, .trailing])
                                        Spacer()
                                    }
                                    else {
                                        MessageView(message: messages[messageInd], displayName: true)
                                            .padding([.leading, .trailing])
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }.flippedUpsideDown()
            }.flippedUpsideDown()
            
            if(inputImage != nil) {
                VStack {
                    Text("Double tap image to remove")
                        .foregroundColor(.gray)
                        .font(Font.custom("Microsoft Tai Le", size: 14))
                        .padding(.top)
                    Image(uiImage: inputImage!)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding([.leading, .trailing])
                        .onTapGesture(count: 2, perform: {
                            inputImage = nil
                    })
                }
            }
            
            HStack {
                Image("cameraGray_Icon")
                    .onTapGesture(count: 1, perform: {
                        self.showingImagePicker = true
                    })
                TextField("Send Message", text: $toSend, onCommit: {
                    var mediaURL = ""
                    if(inputImage != nil) {
                        UploadImage(image: inputImage!) { url in
                            mediaURL = url
                            
                            SendMessage(text: toSend, mediaURL: mediaURL)
                            
                            toSend = ""
                            inputImage = nil
                        }
                    }
                    else {
                        SendMessage(text: toSend)
                        toSend = ""
                    }
                })
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
            ref.removeObserver(withHandle: postHandle)
        }
        .sheet(isPresented: $showingImagePicker/*, onDismiss: loadImage*/) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    /*func loadImage() {
        guard let inputImage = inputImage else { return }
        
    }*/
    
    init(userID: UUID, propertyID: UUID) {
        self.userID = userID
        self.propertyID = propertyID
    }
    
    func SendMessage(text: String, mediaURL: String? = nil) {
        // Don't upload empty messages
        if(text == "" && mediaURL == nil) {
            return
        }
        
        let message = Message(senderID: userID,
                              sender: "NotBen",
                              text: text,
                              date: Date(),
                              mediaURL: mediaURL)
        
        ref.child(message.id.uuidString).setValue(message.dictionary)
    }
    
    func UploadImage(image: UIImage, completion:@escaping((String) -> ())) {
        // TODO: Scale image to smaller size if too large
        var storageRef = Storage.storage().reference()
        
        guard let data = image.jpegData(compressionQuality: 0.4)
        else {
            completion("")
            return
        }
        
        let metadata = StorageMetadata()
        
        metadata.contentType = "image/jpg"
        
        storageRef = storageRef.child("messageData/" + propertyID.uuidString)
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        
        storageRef = storageRef.child(imageName)
        
        var url = ""
        
        storageRef.putData(data, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                completion("")
                return
            }
            
            storageRef.downloadURL { (downloadurl, error) in
                url = downloadurl!.absoluteString
                completion(url)
            }
        }
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
