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
    
    @State var displayCreatePage = false
    @State var action: Bool = false
    @State var errorText: String = ""
    @State var showAlert: Bool = false
    @State var firstAppearance = true
    
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
                    
                    Text("Create an account")
                        .onTapGesture(count: 1, perform: {
                            self.displayCreatePage.toggle()
                        })
                        .foregroundColor(Color("TextGreen"))
                        .padding(10)
                        .sheet(isPresented: $displayCreatePage, content: {
                            CreateAccountPage(dismiss: $displayCreatePage, returnUserName: $userName)
                        })
                    
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
                               isActive: $action){}.navigationBarHidden(true)
                Image("triangle")
                    .resizable()
                    .scaledToFit()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                    maxHeight: .infinity, alignment: .bottom)
          
        
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                maxHeight: .infinity).edgesIgnoringSafeArea([.bottom, .top])
            .onAppear() {
                password = ""
                userName = ""
                if(firstAppearance && Auth.auth().currentUser != nil) {
                    action = true
                    firstAppearance = false
                }
        }
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
                firstAppearance = false
            }
        }
}
