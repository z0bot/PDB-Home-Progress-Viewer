//
//  PropertySelectionView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/23/20.
//

import SwiftUI

struct ProjectSelectionView: View {
    var project: Project
    
    var body: some View {
        VStack(spacing: .none) {
            Image("HouseTemp")
                .resizable()
                .cornerRadius(20)
                .scaledToFit()
            
            Text(project.name)
                .font(Font.custom("Microsoft Tai Le", size: 15))
                .bold()
                .foregroundColor(Color("TextGreen"))
        }
    }
}

struct ProjectSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectSelectionView(project: Project(imageURL: "", name: "Bernie St.", address: ""))
    }
}
