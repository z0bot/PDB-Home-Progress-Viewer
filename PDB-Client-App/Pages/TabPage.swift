//
//  TabPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import SwiftUI

struct TabPage: View {
    var project: Project
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            Text("Tab1")
                .tabItem {
                    if(selection == 0) {
                        Image("messageActive_Icon")
                    }
                    else {
                        Image("messageCircle_Icon")
                    }
                }.tag(0)
            
            /*ProgressGalleryPage(rooms: project.rooms)*/
            ProgressGalleryPage(rooms: project.rooms)
                .tabItem {
                    if(selection == 1) {
                        Image("galleryActive_Icon")
                    }
                    else {
                        Image("gallery_Icon")
                    }
                }.tag(1)
            ChangeOrderPage(forms: project.changeOrderForms)
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

struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage(project: Project(imageURL: "", name: "Proj1", address: "addr1", rooms: [Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                                      ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer"),
                             Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Dining Room")], forms: [ChangeOrderForm(title: "A form", description: "A description")]))
    }
}
