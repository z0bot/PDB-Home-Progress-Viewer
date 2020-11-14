//
//  CreateAccountPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/5/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct CreateAccountPage: View {
    @Binding var dismiss: Bool
    @Binding var returnUserName: String
    
    @State var userName = ""
    @State var phone = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State var confirmedPassword = ""
    
    @State var errorText: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Create Account")
                    .bold()
                    .foregroundColor(Color("TextGreen"))
                    .font(Font.custom("Microsoft Tai Le", size: 35))
                    .padding()
                
                Spacer()
                
                Image("plus")
                    .rotationEffect(.degrees(45))
                    .padding()
                    .onTapGesture(count: 1, perform: {
                        dismiss.toggle()
                    })
            }
            
            VStack {
                Group {
                    HStack {
                        Image("email")
                        TextField("Email", text: $userName)
                            .padding([.leading])
                    }
                    Divider()
                    
                    HStack {
                        ZStack {
                            Image("phone")
                                .resizable()
                                .opacity(0.0999)
                            Color("IconColor").blendMode(.colorBurn)
                        }
                        .frame(width: 30, height: 31, alignment: .center)
                        TextField("Phone Number", text: $phone)
                            .padding([.leading])
                    }
                    Divider()
                    
                    HStack {
                        Image("profile")
                        TextField("First Name", text: $firstName)
                            .padding([.leading])
                    }
                    Divider()
                }
                
                HStack {
                    Image("profile")
                    TextField("Last Name", text: $lastName)
                        .padding([.leading])
                }
                Divider()
                
                Group {
                    HStack {
                        Image("lock2")
                        SecureField("Password", text: $password)
                            .padding([.leading])
                    }
                    Divider()
                    
                    HStack {
                        Image("confirmLock")
                        SecureField("Confirm Password", text: $confirmedPassword)
                            .padding([.leading])
                    }
                }
            }.padding([.leading, .trailing, .top], 30)
            //Divider()
            Spacer()
            
            
            HStack {
                Spacer()
                Image("rightArrow")
                    .padding()
                    .onTapGesture(count: 1, perform: {
                        CreateUser()
                    })
                    .alert(isPresented: self.$showAlert, content: {
                            Alert(title: Text("Error Creating User"), message: Text(errorText),
                                  dismissButton: .cancel(Text("Ok"))
                                  )})
                    
            }
            .padding()
        }
    }
    
    func CreateUser()
    {
        if(phone.count == 0 || firstName.count == 0 || lastName.count == 0) {
            self.errorText = "All fields are required."
            showAlert = true
            return
        }
        else if(!phone.isPhoneNumber) {
            self.errorText = "Invalid phone number."
            showAlert = true
            return
        }
        else if(password != confirmedPassword) {
            self.errorText = "Passwords must match."
            showAlert = true
            self.password = ""
            self.confirmedPassword = ""
            return
        }
        else {
            Auth.auth().createUser(withEmail: userName, password: password) {user, error in
                if let error = error
                {
                    self.errorText = error.localizedDescription
                    showAlert = true
                    self.password = ""
                    self.confirmedPassword = ""
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("Users").addDocument(data: [
                    "users_email": userName,
                    "users_firstname": firstName,
                    "users_lastname": lastName,
                    "users_phone": phone
                ])
                
                returnUserName = userName
                dismiss.toggle();
            }
        }
       
    }
}

extension String {
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in:
                                            self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
            }
            else {
                return false
            }
        } catch {
            return false
        }
    }
}

struct CreateAccountPage_Previews: PreviewProvider {
    @State static var dismiss = false
    @State static var userName = "UserName"
    static var previews: some View {
        CreateAccountPage(dismiss: $dismiss, returnUserName: $userName)
    }
}
