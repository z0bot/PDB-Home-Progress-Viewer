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
        Project(imageURL: "", name: "Proj1", address: "addr1"),
        Project(imageURL: "", name: "Proj2", address: "addr2"),
        Project(imageURL: "", name: "Proj3", address: "addr3")
    ]
}
