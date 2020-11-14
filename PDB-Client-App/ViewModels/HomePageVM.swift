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
    @Published var Rooms = [Room]()
    @Published var Forms = [ChangeOrderForm]()
    @Published var Images = [ImageModel]()
    @Published var roomIds = [String]()
    private var db = Firestore.firestore()

    
    func getData()
    {
        let projectRef = db.collection("Projects")
            let projectQuery = projectRef.whereField("builderEmail", isEqualTo: "B@T.com")
            projectQuery.getDocuments{QuerySnapshot, error in
                for document in QuerySnapshot!.documents
                    {
                        let name = document.data()["name"] as? String ?? ""
                        let builderEmail = document.data()["builderEmail"] as? String ?? ""
                        let imageURL = document.data()["imageURL"] as? String ?? ""
                        let address = document.data()["address"] as? String ?? ""
                        let archived = document.data()["archived"] as? Bool ?? false
                        let form = document.data()["changeOrderForm"] as? ChangeOrderForm ?? nil
                        
                        self.Projects.append(Project(email: builderEmail, imageURL: imageURL, name: name, address: address, docId: document.documentID))
                    
                            
                    }
                
                    
            }
        
    }
    
    func getRooms(pId: String)
    {
            let roomQuery = db.collection("Projects").document(pId).collection("Rooms")
            roomQuery.getDocuments
            { QuerySnapshot, error in
                if let error = error{}
                else
                {
                    for document in QuerySnapshot!.documents
                        {
                            let name = document.data()["name"] as? String ?? ""
                            var i = 0
                            for p in self.Projects
                            {
                                if p.docId == pId
                                {
                                    self.Projects[i].rooms?.append(Room(name: name, docId: document.documentID))
                                }
                                i = i + 1
                            }
                        }
                  }
            }
        }
    
    
    
    func getImages()
    {
        var i=0
        for(p) in Projects
        { var k = 0
            for(r) in p.rooms!
            {
                let imageQuery = db.collection("Projects").document(p.docId).collection("Rooms").document(r.docId).collection("Images")
               
                imageQuery.getDocuments()
               {
                (QuerySnapshot, err) in
                    if let err = err{}
                    else
                    {
                        for document in QuerySnapshot!.documents
                        {
                            let imageURL = document.data()["imageURL"] as? String ?? ""
                            self.Projects[i].rooms?[k].images?.append(ImageModel(imageURL: imageURL, date: Date(timeIntervalSinceNow: 0)))
                        }
                    }
               }
                k = k+1
            }
            i = i+1
        }
    }
}
    
    
    
    
    
    
    
    
    
    /*func getData(){
    let projectRef = db.collection("Projects")
        let projectQuery = projectRef.whereField("builderEmail", isEqualTo: "B@T.com")
        projectQuery.getDocuments() {(QuerySnapshot, err) in
            if let _err = err{}
            else{
                var project:Project
                for document in QuerySnapshot!.documents
                {
                    let name = document.data()["name"] as? String ?? ""
                    let builderEmail = document.data()["builderEmail"] as? String ?? ""
                    let imageURL = document.data()["imageURL"] as? String ?? ""
                    let address = document.data()["address"] as? String ?? ""
                    let archived = document.data()["archived"] as? Bool ?? false
                    let form = document.data()["changeOrderForm"] as? ChangeOrderForm ?? nil
                    var rooms=[Room]()
                
                    let roomQuery = projectRef.document(document.documentID).collection("Rooms")
                                        roomQuery.getDocuments()
                    {
                        (QuerySnapshot, err) in
                        if let err = err{}
                        else
                        {
                            var room:Room
                           
                            for document in QuerySnapshot!.documents
                            {
                                let name = document.data()["name"] as? String ?? ""
                                var images = [ImageModel]()
                                let imageQuery = roomQuery.document(document.documentID).collection("Images")
                               
                                imageQuery.getDocuments()
                               {
                                (QuerySnapshot, err) in
                                    if let err = err{}
                                    else
                                    {
                                        for document in QuerySnapshot!.documents
                                        {
                                            let imageURL = document.data()["imageURL"] as? String ?? ""
                                            let image = ImageModel(imageURL: imageURL, date: Date(timeIntervalSinceNow: 0))
                                            images.append(image)
                                        }
                                    }
                               }
                                room = Room(images: images, name: name)
                                rooms.append(room)
                            }
                        }
                    }
                    project = Project(email: builderEmail, imageURL: imageURL, name: name, address: address, rooms: rooms)
                    self.Projects.append(project)
                }
            }
        }
    }
}*/
    
    
    
    
    
    
    
    
    /*func fetchProjects()
    {
        
        db.collection("Projects").whereField("builderEmail", isEqualTo: "B@Test.com").addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
            }
                self.Projects = documents.map { (queryDocumentSnapshot) -> (Project) in
                let data = queryDocumentSnapshot.data()
                let email = data["builderEmail"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let imageURL = data["imageURL"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                //let archived = data["archived"] as? Bool ?? false
                //let forms = data["ChangeOrderForms"] as? String ?? ""
                //var rooms = data["Rooms"] as? String ?? ""
                let id = data["id"] as? String ?? ""
 
                self.fetchRoom(projId: id)
                
                let a = Project(email: email, imageURL: imageURL, name: name, address: address, rooms: self.Rooms, forms: self.Forms)
                    return a
            }
            
    
    }
        func fetchRoom(projId:String)
        {
            db.collection("Rooms").whereField("projectId", isEqualTo: projId).addSnapshotListener{(querySnapshot, error) in
                guard let documents = querySnapshot?.documents else{
                    print("No Documents")
                    return
                }
            
                self.Rooms = documents.map { (QueryDocumentSnapshot) -> (Room) in
                let data = QueryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let id = data["roomId"] as? String ?? ""
                self.fetchImages(roomId: id)
        

                return Room(id: UUID(), images: self.Images, name: name, projectId: projId)
            }
            }
            
        }
    func fetchImages(roomId: String)
    {
        db.collection("Images").whereField("roomId", isEqualTo: roomId).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else{
                print("No Documents")
                return
            }
        
            self.Images = documents.map { (queryDocumentSnapshot) -> (ImageModel) in
            let data = queryDocumentSnapshot.data()
            let images = data["imageList"] as? String ?? ""
            return ImageModel(id: UUID(), imageData: images, date: Date())
            }
        }
    }*/
    
    
        
            
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



struct HomePageVM_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

