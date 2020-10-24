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
                .cornerRadius(25)
                .scaledToFit()
            
            Text(project.name)
                .font(.subheadline)
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
