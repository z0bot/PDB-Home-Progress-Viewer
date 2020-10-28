//
//  HomePageVM.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//

import SwiftUI
import Combine

class HomePageVM: ObservableObject {
    //TODO: Pull these from the logged in user
    @Published var projects = [
        Project(imageURL: "", name: "Proj1", address: "addr1", rooms: [Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                     ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer"),
            Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Dining Room")]),
        Project(imageURL: "", name: "Proj2", address: "addr2"),
        Project(imageURL: "", name: "Proj3", address: "addr3")
    ]
}
