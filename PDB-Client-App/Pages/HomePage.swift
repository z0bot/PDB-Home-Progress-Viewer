//
//  HomePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI
import Combine

struct HomePage: View {
    // If we need to pass in this data later, use @EnvironmentObject instead of @ObservedObject
    @ObservedObject var viewModel = HomePageVM()
    
    private var cols: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        VStack {
            Image("PDBLogo")
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            
            
            
            
            HStack {
                Text("Select Home")
                    .bold()
                    .foregroundColor(Color("TextGreen"))
                    .font(Font.custom("Microsoft Tai Le", size: 23))
                
                Spacer()
                
                Image("plus")
                    .gesture(TapGesture().onEnded({
                        //TODO: Add functionality for adding a new property
                        viewModel.projects.append(Project(imageURL: "", name: "newProj", address: "aaa"))
                    }))
            }.padding()
            
            ScrollView {
                LazyVGrid(columns: cols,
                          spacing: 30) {
                    
                    ForEach(viewModel.projects) { project in
                        //TODO: Make navigation happen when you tap on one of the ProjectSelectionViews
                        NavigationLink(destination: Text(project.name)) {
                            ProjectSelectionView(project: project)
                        }.navigationBarHidden(true)
                        .navigationTitle("")
                    }
                }
                .padding()
                
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray,
                            lineWidth: 1)
            )
            .padding(.all)
            
            HStack() {
                //TODO: Add logout functionality tap gesture recognizer
                Text("Logout")
                    .font(Font.custom("Microsoft Tai Le", size: 23))
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
