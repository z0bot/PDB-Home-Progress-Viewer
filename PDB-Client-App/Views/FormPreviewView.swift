//
//  FormPreviewView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/27/20.
//

import SwiftUI

struct FormPreviewView: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image("")
            Image("HouseTemp")
                .resizable()
                .scaledToFit()
            
            Text("name")
                .font(Font.custom("Microsoft Tai Le", size: 14))
                .padding([.leading, .trailing,.bottom])
        }
    }
}

struct FormPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        FormPreviewView()
    }
}
