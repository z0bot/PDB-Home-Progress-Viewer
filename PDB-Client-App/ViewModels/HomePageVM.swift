//
//  HomePageVM.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//

import Foundation
import Combine

class HomePageVM: ObservableObject {
    let didChange = PassthroughSubject<HomePageVM,Never>()
    
    var projects = [Project]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        self.projects = [
            Project(imageURL: "", name: "Proj1", address: "addr1"),
            Project(imageURL: "", name: "Proj2", address: "addr2"),
            Project(imageURL: "", name: "Proj3", address: "addr3")
        ]
    }
    
    
}
