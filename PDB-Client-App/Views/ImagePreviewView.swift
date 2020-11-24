//
//  ImagePreviewView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import SwiftUI
import Firebase
import FirebaseStorage
import URLImage

struct ImagePreviewView: View {
    var image: ImageModel
    var body: some View {
        
        VStack(spacing: .none) {
            URLImage(url: URL(string: image.imageURL)!) { image in
                image.resizable()
                    .cornerRadius(20)
                    .scaledToFill()
                    .opacity(0.5)
                        
            }.frame(width: 120, height: 120, alignment: .center)
            .cornerRadius(20)
            
            Text(image.DateString())
                .font(Font.custom("Microsoft Tai Le", size: 23))
                .bold()
                .foregroundColor(.black)
                .padding(.top, -70.0)
        }
    }
    
    
}

/*struct ImagePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewView(image: ImageModel(imageData: "", date: Date()))
    }
}*/
