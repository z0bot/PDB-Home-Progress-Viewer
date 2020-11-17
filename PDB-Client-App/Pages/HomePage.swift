//
//  HomePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI
import Combine
import ASCollectionView

struct HomePage: View {
    // If we need to pass in this data later, use @EnvironmentObject instead of @ObservedObject
    @ObservedObject var viewModel = HomePageVM()
    
    /*private var cols: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]*/
    
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
                        viewModel.projects.append(Project(imageURL: "https://firebasestorage.googleapis.com/v0/b/pd-builders.appspot.com/o/testProject%2FPDB%20(2).jpg?alt=media&token=b2cacd69-40ca-4ea4-869c-635d1b500743", name: "newProj", address: "aaa"))
                    }))
            }.padding()
            
            //ScrollView {
                
                ASCollectionView(data: viewModel.projects) { project,arg  in
                    
                    NavigationLink(destination:
                                    TabPage(project: project)
                    ) {
                        ProjectSelectionView(project: project)
                    }.navigationBarHidden(true)
                    .padding([.top])
                    
                }.layout {
                    .grid()
                }.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray,
                                lineWidth: 1)
                )
                //.frame(height: .infinity)
                .padding(.all)
                /*LazyVGrid(columns: cols,
                          spacing: 30)*/
                /*Grid(tracks: 2) {
                    
                    ForEach(viewModel.projects) { project in
                        
                        NavigationLink(destination:
                                        TabPage(project: project)
                        ) {
                            ProjectSelectionView(project: project)
                        }.navigationBarHidden(true)
                        .padding()
                        //TODO: Make navigation happen when you tap on one of the ProjectSelectionViews
                    }
                }.gridContentMode(.scroll)*/
                
                //}
                //.frame(height: .infinity)
                /*.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray,
                                lineWidth: 1)
                )
                .padding(.all)*/
                
            /*}.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray,
                            lineWidth: 1)
            )
            .padding(.all)*/
            
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
        }.onAppear(){self.viewModel.getProjects()}
    }
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
