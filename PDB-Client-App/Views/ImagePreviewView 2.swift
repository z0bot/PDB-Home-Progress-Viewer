//
//  ImagePreviewView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/26/20.
//

import SwiftUI

struct ImagePreviewView: View {
    var image: ImageModel
    var body: some View {
        VStack {
            Image("HouseTemp")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
            
            Text("hewwo")
                .font(Font.custom("Microsoft Tai Le", size: 15))
                .bold()
                .foregroundColor(.white)
                .padding(.top, -120.0)
                .font(.system(size: 23))
        }
    }
}

struct ImagePreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreviewView(image: ImageModel(imageData: "", date: Date()))
    }
}
