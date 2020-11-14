//
//  TabPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import SwiftUI

struct TabPage: View {
    @Binding var project: Project
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            MessagePage(userID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, messages: [Message(senderID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F")!, sender: "BC", text: "Hey", date: Date()), Message(senderID: UUID(uuidString: "E621E1F8-C36C-495A-93FC-0C247A3E6E5E")!, sender: "BC", text: "Hey 2 u", date: Date())])
                .tabItem {
                    if(selection == 0) {
                        Image("messageActive_Icon")
                    }
                    else {
                        Image("messageCircle_Icon")
                    }
                }.tag(0)
            
            /*ProgressGalleryPage(rooms: project.rooms)*/
            ProgressGalleryPage(project: $project)
                .tabItem {if(selection == 1) {
                        Image("galleryActive_Icon")
                    }
                    else {
                        Image("gallery_Icon")
                    }
                }.tag(1)
            ChangeOrderPage(project: $project)
                .tabItem {
                    if(selection == 2) {
                        Image("fileActive_Icon")
                    }
                    else {
                        Image("file_Icon")
                    }
                }.tag(2)
        }
    }
}

/*struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage(project: Project(email: "", imageURL: "", name: "Proj1", address: "addr1", rooms: [Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                                                 ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer", projectId: "ads"),
                             Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Dining Room", projectId: "ads")], forms: [ChangeOrderForm(title: "A form", description: "A description")]))
    }
}*/
