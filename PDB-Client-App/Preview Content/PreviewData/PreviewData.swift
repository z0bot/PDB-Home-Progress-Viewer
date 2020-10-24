//
//  PreviewProject.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import Foundation

public class PreviewData {
    @Published var previewProject: Project = Project(imageURL: "", name: "Bernie St.", address: "")
    
    @Published var previewClient: Client = Client(name: "Big Daddy", phoneNumber: "555-555-5555", emailAddress: "big@daddy.com")
}

