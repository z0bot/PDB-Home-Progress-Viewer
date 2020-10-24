//
//  HomePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI

struct HomePage: View {
    private var cols: [GridItem] = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    var body: some View {
        
        VStack {
            Image("PDBLogo")
            
            Spacer()
            
            HStack {
                Text("Select Home")
                    .foregroundColor(.green)
                    .bold()
                
                Spacer()
                
                Image("plus")
            }.padding()
            
            ScrollView {
            LazyVGrid(columns: cols) {
                
                ForEach((1..<10)) { i in
                    Text("Placeholder")
                    Text("Placeholder")
                    Text("Placeholder")
                    Text("Placeholder")
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
                    .foregroundColor(.green)
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
