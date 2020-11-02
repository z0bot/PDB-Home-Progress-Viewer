//
//  LoginPage.swift
//  PDB-Client-App
//
//  Created by Blake Cox on 10/27/20.
//

import SwiftUI
import FirebaseAuth

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
                    TextField("Username", text: $userName)
                    Divider()
                    SecureField("Password", text: $password)
                    Divider()
                    Button(action: {}){Text("Create an account").foregroundColor(Color("TextGreen"))}.padding(10)
                    Spacer(minLength: 10)
                        Button(action: SubmitLogin){
                            Text("Login").padding([.top, .bottom], 12.0)
                                .padding([.leading, .trailing], 30)
                                .alert(isPresented: self.$showAlert, content: {
                                        Alert(title: Text("Login Error"), message: Text("Invalid Username or Password"),
                                              dismissButton: .cancel(Text("Ok"))
                                              )}
                                        )
                                
                                        
                                
                                .font(.title2)
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
}
