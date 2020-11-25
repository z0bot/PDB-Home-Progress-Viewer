//
//  HomePage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/22/20.
//

import SwiftUI
import Combine
import ASCollectionView
import FirebaseAuth

struct HomePage: View {
    // If we need to pass in this data later, use @EnvironmentObject instead of @ObservedObject
    @ObservedObject var viewModel = HomePageVM()
    @State var showAlert = false
    @State var projectCode: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
                
                Image("plus").onTapGesture(count: 1, perform: {
                    self.showAlert.toggle()
                })
                .foregroundColor(Color("TextGreen"))
                .padding(10)
                
                /*.sheet(isPresented: $displayAddProjectPage, content: {
                    AddProjectPage(dismiss: $displayAddProjectPage, returnprojectCode: $projectCode)
                })*/
                    
            }.padding()
            
            //ScrollView {
            ZStack{
                ASCollectionView(data: viewModel.projects) { project,arg  in
                    
                    NavigationLink(destination:
                                    TabPage(project: project, vm: viewModel)
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
                AddProjectPage(vm: viewModel, isShown: $showAlert, returnprojectCode: $projectCode)
        }
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
                .onTapGesture {
                    logOut()
                }
                Spacer()
            }
            .padding()
            .frame(alignment: .leading)
        }.onAppear(){self.viewModel.getProjects()}
        .navigationBarBackButtonHidden(true)
    }
    
    func logOut()
    {
        do {
            try Auth.auth().signOut()
            self.presentationMode.wrappedValue.dismiss()
            
        } catch let err {
            print(err)
        }
    
    }
}
struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
