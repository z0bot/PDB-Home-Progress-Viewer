//
//  MessagePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/3/20.
//

import SwiftUI
import AVFoundation
import Firebase
import FirebaseStorage

struct MessagePage: View {
    @State var ref: DatabaseReference! = nil
    @State var postHandle: DatabaseHandle = 0
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var userID: String
    var propertyID: String
    var name: String
    
    @State var messages: [Message] = []
    @State var toSend: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer()
                    // This code works on some devices to display the messages without names if they are from the same sender, but it does not yet work well enough to use at the moment
                    /*ForEach(messages.indices) { messageInd in
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
                        }*/
                        ForEach(messages) { message in
                            HStack {
                                if(message.senderID == userID) {
                                    Spacer()
                                    MessageView(message: message, displayName: false, colored: true)
                                        .padding([.leading, .trailing])
                                }
                                else {
                                // Do not display name if previous message came from same sender
                                    MessageView(message: message, displayName: true)
                                        .padding([.leading, .trailing])
                                    Spacer()
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
                        switch AVCaptureDevice.authorizationStatus(for: .video) {
                            case .authorized: // The user has previously granted access to the camera.
                                self.showingImagePicker = true
                            
                            case .notDetermined: // The user has not yet been asked for camera access.
                                AVCaptureDevice.requestAccess(for: .video) { granted in
                                    if granted {
                                        self.showingImagePicker = true
                                    }
                                }
                            
                            case .denied: // The user has previously denied access.
                                return

                            case .restricted: // The user can't grant access due to restrictions.
                                return
                        @unknown default:
                            fatalError()
                        }
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
        }
        .onLoad {
            ref = Database.database()
                .reference().child("messaging")
                .child("projects")
                .child(propertyID)
            
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
            //ref.removeAllObservers()
        }
        .sheet(isPresented: $showingImagePicker/*, onDismiss: loadImage*/) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    /*func loadImage() {
        guard let inputImage = inputImage else { return }
        
    }*/
    
    init(propertyID: String) {
        self.userID = (Auth.auth().currentUser?.email)!
        self.propertyID = propertyID
        self.name = Auth.auth().currentUser?.displayName ?? "Unknown name"
    }
    
    func SendMessage(text: String, mediaURL: String? = nil) {
        // Don't upload empty messages
        if(text == "" && mediaURL == nil) {
            return
        }
        
        let message = Message(senderID: userID,
                                  sender: name,
                                  text: text,
                                  date: Date(),
                                  mediaURL: mediaURL)
            
        ref.childByAutoId().setValue(message.dictionary)
    }
    
    func getFirstName(email: String, completion:@escaping ((String) -> ())) {
        var db = Firestore.firestore().collection("Users")
        
        let query = db.whereField("users_email", isEqualTo: email)
        
        query.getDocuments { QuerySnapshot, error in
            var user = QuerySnapshot!.documents[0]
            
            let name = user.data()["users_firstname"] as? String
            if(name != nil) {
                completion(name!)
            }
            else {
                completion("")
            }
        }
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
        
        storageRef = storageRef.child("messageData/" + propertyID)
        
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
    
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
            var actionPerformed = false
            return self.onAppear {
                guard !actionPerformed else {
                    return
                }
                actionPerformed = true
                action?()
            }
        }
}

struct MessagePage_Previews: PreviewProvider {
    static var previews: some View {
        MessagePage(propertyID:  "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")
    }
}
