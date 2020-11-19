//
//  AddProjectPage.swift
//  PDB-Client-App
//
//  Created by Blake Cox on 11/17/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AddProjectPage: View {
    @Binding var isShown: Bool
    @Binding var returnprojectCode: String
    @State var projectCode = ""
    @State var errorText: String = ""
    @State var showAlert: Bool = false
    
    let screenSize = UIScreen.main.bounds
    var body: some View {
        
    
        VStack(alignment: .trailing, spacing: 0) {
            Image("plus")
                .rotationEffect(.degrees(45))
                .onTapGesture(count: 1, perform: {
                    isShown.toggle()
                }).padding(.bottom,30)
                
            ZStack{
           
            VStack(alignment: .center, spacing: 0){
                    Text("Enter 6 character access code to add a new home")
                        .padding(.top,60)
                        .padding(.horizontal, 30)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
        
                TextField("", text: $projectCode)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("TextGreen"))
                    .padding(.horizontal, 60)
         
                Divider()
                    .frame(height:1)
                    .background( Color("TextGreen"))
                    .padding(.horizontal, 80)
                    .padding(.bottom, 30)
                    
                    
          
            }
            .background(Color("LightGreenAccent"))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))
            
                
                VStack(alignment: .center){
                
                    Button(action: AddProject){
                        HStack{
                            Spacer()
                            Text("Add Home")
                                .fontWeight(.heavy)
                                .font(Font.custom("Microsoft Tai Le", size: 30))
                            Spacer()
                            
                        }
                    }
                        .foregroundColor(Color("TextGreen"))
                    .padding(5)
                    .padding(.bottom, 6)
                        .alert(isPresented: self.$showAlert, content: {
                            Alert(title: Text("Error Adding Project"), message: Text(errorText),
                                  dismissButton: .cancel(Text("Ok"))
                                  )})
            
                }.background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1))
                .padding(.bottom, -6)
                .layoutPriority(0)
                
                .offset(y: -60)
                
            }
            
        }.offset(y: isShown ? 0 : screenSize.height)
        .animation(.easeInOut)
        .padding(.horizontal, screenSize.width * 0.1)
        
      
        
                    
           
        
        
    }
    
    func AddProject()
    {
        if(projectCode.count < 6 || projectCode.count > 6) {
            self.errorText = "The project code must be 6 characters."
            showAlert = true
            return
        }
        else {
            let db = Firestore.firestore()
        db.collection("Projects").document(projectCode).getDocument { (document, error) in
            if let document = document, document.exists {
                    returnprojectCode = projectCode
                isShown.toggle()
                } else {
                    self.errorText = "Not a valid project code."
                    showAlert = true
                    return
                }}
               }
    }
}


struct AddProjectPage_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectPage(isShown: .constant(true), returnprojectCode: .constant("")).background(Color.white)
    }
}
