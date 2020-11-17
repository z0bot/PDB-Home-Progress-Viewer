//
//  PropertySelectionView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import SwiftUI
import Firebase
import FirebaseStorage
import URLImage

struct ProjectSelectionView: View {
    var project: Project
    @State var uiImage: UIImage?
   
    var body: some View {
       
        VStack(spacing: .none) {
            URLImage(url: URL(string: project.imageURL)!) { image in
                image.resizable()
                    .scaledToFill()
                        
            }.frame(width: 120, height: 120, alignment: .center)
            .cornerRadius(20)
            
            
                Text(project.name)
                    .font(Font.custom("Microsoft Tai Le", size: 15))
                    .bold()
                    .foregroundColor(Color("TextGreen"))
        }
    }
}
    



/*struct ProjectSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelectionView(project: Project(imageURL: "", name: "Bernie St.", address: ""))
    }
}*/
 
