//
//  HomePageVM.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/24/20.
//

import SwiftUI
import Combine
import Firebase
import FirebaseFirestore

class HomePageVM: ObservableObject {
    @Published var projects = [Project]()
    @Published var rooms = [Room]()
    
    var db = Firestore.firestore().collection("Projects")
    func getProjects()
    {   self.projects = [Project]()
        let projectQuery = db.whereField("builderEmail", isEqualTo: "B@T.com")
        projectQuery.getDocuments{QuerySnapshot, error in
            for document in QuerySnapshot!.documents
            {  self.rooms = []
                
                let name = document.data()["name"] as? String ?? ""
                let builderEmail = document.data()["builderEmail"] as? String ?? ""
                let imageURL = document.data()["imageURL"] as? String ?? "https://firebasestorage.googleapis.com/v0/b/pd-builders.appspot.com/o/testProject%2FPDB%20(2).jpg?alt=media&token=b2cacd69-40ca-4ea4-869c-635d1b500743"
                let address = document.data()["address"] as? String ?? ""
                let archived = document.data()["archived"] as? Bool ?? false
                let id = document.documentID
                
                self.getRooms(id: id)
                    { rooms in
                        
                        self.getForms(id: id) { forms in
                            self.projects.append((Project(builderEmail: builderEmail, imageURL: imageURL, name: name, address: address, archived: archived, rooms: rooms, forms: forms, docId: id)))
                        }
                    }
                
                
            }
        }
    }
    
    func getRooms(id: String, completion: @escaping (([Room]) -> ()))
    {
        var rooms = [Room]()
        self.db.document(id).collection("Rooms").getDocuments
        {
            QuerySnapshot, error in
            for document in QuerySnapshot!.documents
            {
                let name = document.data()["name"] as? String ?? ""
                self.getImages(pid: id, rid: document.documentID)
                {
                    images in
                    rooms.append(Room(id: UUID(), name: name, images: images))
                    
                }
                
            }
            completion(rooms)
        }
    }
    
    func getImages(pid: String, rid: String, completion: @escaping (([ImageModel]) -> ()))
    {
        var images = [ImageModel]()
        self.db.document(pid).collection("Rooms").document(rid).collection("Images").getDocuments(completion:
        {
            QuerySnapshot, error in
     
                for document in QuerySnapshot!.documents
                {
                    let imageRef = document.data()["imageURL"] as? String ?? ""
                    images.append(ImageModel(id: UUID(), imageURL: imageRef, date: Date(timeIntervalSinceNow: 0)))
                    
                }
        })
        completion(images)
    }

    func getForms(id: String, completion:@escaping ((([ChangeOrderForm]) -> ()))) {
        var forms = [ChangeOrderForm]()
        
        self.db.document(id).collection("Forms").getDocuments(completion:
        {
            QuerySnapshot, error in
     
                for document in QuerySnapshot!.documents
                {
                    let fireID = document.documentID
                    let title = document.data()["title"] as? String ?? ""
                    let dateStr = document.data()["date"] as? String ?? ""
                    let date = Date.String(from: dateStr)
                    
                    let formHTML = document.data()["html"] as? String ?? ""
                    let signed = document.data()["signed"] as? Bool ?? false
                    forms.append(ChangeOrderForm(fireID: fireID, title: title, date: date, htmlData: formHTML, signed: signed))
                    
                }
            completion(forms)
            
        })
    }
}


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


struct HomePageVM_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
