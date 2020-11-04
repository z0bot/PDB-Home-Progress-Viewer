//
//  LoginPage.swift
//  PDB-Client-App
//
//  Created by Blake Cox on 10/27/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginPage: View{
    @State var userName: String = ""
    @State var password: String = ""
    @State var action: Bool = false
    @State var errorText: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        
        GeometryReader{ Geometry in
            VStack(alignment: .center) {
  
                Image("Logowithname")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .center){
                    TextField("Email", text: $userName)
                    Divider()
                    SecureField("Password", text: $password)
                    Divider()
                    Button(action: CreateUser){
                        Text("Create an account")
                            .foregroundColor(Color("TextGreen"))
                            .alert(isPresented: self.$showAlert, content: {
                                    Alert(title: Text("Error Creating User"), message: Text(errorText),
                                          dismissButton: .cancel(Text("Ok"))
                                          )}
                            )}.padding(10)
                    Spacer(minLength: 10)
                    Button(action: SubmitLogin){
                        Text("Login").padding([.top, .bottom], 12.0)
                            .padding([.leading, .trailing], 30)
                            .alert(isPresented: self.$showAlert, content: {
                                    Alert(title: Text("Login Error"), message: Text(errorText),
                                          dismissButton: .cancel(Text("Ok"))
                                          )}
                            )
                            .font(.title)
                        }.background(Color.gray)
                         .foregroundColor(Color.white)
                        .cornerRadius(9)
                        
                        
                }
                .padding(.top, -5.0)
                .padding([.leading, .bottom, .trailing], 50.0)
                
                
            
                
                
            
            VStack(alignment: .center){
                NavigationLink(destination: HomePage(),
                               isActive: $action){}
                Image("triangle")
                    .resizable()
                    .scaledToFit()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                    maxHeight: .infinity, alignment: .bottom)
          
        
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                maxHeight: .infinity).edgesIgnoringSafeArea([.bottom, .top])
    }
            
           
}
        func SubmitLogin()
        {
            Auth.auth().signIn(withEmail: userName, password: password) {user, error in
                if let error = error
                            {
                                self.errorText = error.localizedDescription
                                showAlert = true
                                self.password = ""
                                return
                            }
                action = true
            }
        }
        
        func CreateUser()
        {
            Auth.auth().createUser(withEmail: userName, password: password) {user, error in
                if let error = error
                {
                    self.errorText = error.localizedDescription
                    showAlert = true
                    self.password = ""
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("Users").addDocument(data: [
                    "users_email": userName,
                    "users_firstname": "Blake",
                    "users_lastname": "Cocks2",
                    "users_phone": "1234567890"
                ])
                action = true
            }
            
           
        }
}
