//
//  HomePageVM.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//
import FirebaseFirestore
import Firebase
import SwiftUI
import Combine
import Foundation


class HomePageVM: ObservableObject {
    @Published var Projects = [Project]()
    private var db = Firestore.firestore()
    func fetchData (){
        db.collection("Projects").whereField("builderEmail", isEqualTo: "B@Testy.com").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            self.Projects = documents.map { (queryDocumentSnapshot) -> Project in
                let data = queryDocumentSnapshot.data()
                let email = data["builderEamil"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let archived = data["archived"] as? Bool ?? false
                let rooms = data["rooms"] as? Room ?? nil
                let forms = data["ChangeOrderForms"] as? ChangeOrderForm ?? nil
            
                return Project(email: email, imageURL: imageURL, name: name, address: address, rooms: rooms, forms: forms)
               
            }
    }
       /* public var imageURL: String
        public var name: String
        public var address: String
        public var archived: Bool
        public var rooms: [Room]*/

    //TODO: Pull these from the logged in user
    /*@Published var projects = [
        Project(imageURL: "", name: "Proj1", address: "addr1", rooms: [Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                     ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer"),
            Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Dining Room"),
            Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                         ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer"),
            Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                         ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer"),
            Room(images: [ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0)),
                                                                                         ImageModel(imageData: "This is an image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is another image", date: Date(timeIntervalSinceNow: 0)), ImageModel(imageData: "This is yet another image", date: Date(timeIntervalSinceNow: 0))], name: "Foyer")], forms: [
                                    ChangeOrderForm(title: "A form", description: "A description")                                                     ]),
        Project(imageURL: "", name: "Proj2", address: "addr2"),
        Project(imageURL: "", name: "Proj3", address: "addr3")
    ]*/
}
}

struct HomePageVM_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

