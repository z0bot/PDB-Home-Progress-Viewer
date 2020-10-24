//
//  HomePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI

struct HomePage: View {
    private var cols: [GridItem] = [
        GridItem(.flexible(minimum: 100, maximum: 300), spacing: 20),
        GridItem(.flexible(minimum: 100, maximum: 300), spacing: 20)
    ]
    
    var body: some View {
        
        VStack {
            Image("PDBLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                
            
            Spacer()
            
            HStack {
                Text("Select Home")
                    .foregroundColor(Color("TextGreen"))
                    .bold()
                
                Spacer()
                
                Image("plus")
            }.padding()
            
            ScrollView {
                LazyVGrid(columns: cols,
                          spacing: 30) {
                    
                    ForEach((1..<10)) { i in
                        ProjectSelectionView(project: Project(imageURL: "", name: "2020 Bernie St.", address: ""))
                    }
                    
                }
                .padding()
            
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray,
                            lineWidth: 1)
            )
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            HStack() {
                Text("Logout")
                    .bold()
                    .foregroundColor(Color("TextGreen"))
                Spacer()
            }
            .padding()
            .frame(alignment: .leading)
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
