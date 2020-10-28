//
//  TabPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import SwiftUI

struct TabPage: View {
    var project: Project
    
    var body: some View {
        TabView {
            Text("Tab1")
                .tabItem {
                    Image("messageCircle_Icon").padding()
                }
            ProgressGalleryPage(rooms: project.rooms)
                .tabItem {
                    Image("gallery_Icon")
                        .resizable()
                        .padding()
                }
            Text("Tab3")
                .tabItem {
                    Image("file_Icon")
                        .resizable()
                        .padding()
                }
        }
    }
}

struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage(project: Project(imageURL: "", name: "TestProj", address: "TestProj Ln"))
    }
}
