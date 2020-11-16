//
//  PropertySelectionView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import SwiftUI
import Firebase
import FirebaseStorage
struct ProjectSelectionView: View {
    var project: Project
   
    var body: some View {
       
        VStack(spacing: .none) {
        
            UIImage(named: getUIImage(completion: {
                image in
                
            }))
            
                Image("Image")
                    .resizable()
                    .cornerRadius(20)
                    .scaledToFit()
                
                Text(project.name)
                    .font(Font.custom("Microsoft Tai Le", size: 15))
                    .bold()
                    .foregroundColor(Color("TextGreen"))
        }
    }
    func getUIImage(completion: @escaping ((UIImage) -> ()))
    {
        let storage = Storage.storage()
        var image = UIImage()
        let gsRef = storage.reference(forURL: project.imageURL)
        gsRef.getData(maxSize: 1*1024*1024) {
            data, error in
            if let error = error {
               // Uh-oh, an error occurred!
             } else {
               // Data for "images/island.jpg" is returned
                image = UIImage(data: data!)!
                
             }
            completion(image)
        }
    }
}


/*struct ProjectSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelectionView(project: Project(imageURL: "", name: "Bernie St.", address: ""))
    }
}*/
 
