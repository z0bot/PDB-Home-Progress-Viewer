//
//  SignFormPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/31/20.
//
import UIKit
import SwiftUI
import Firebase

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
struct SignFormPage: View {
    var form: ChangeOrderForm
    var projectID: String
    @ObservedObject var vm: HomePageVM
    @State var isSigned = false
    @State var isNewlySigned = false
    @State var signedname = ""
    @State var showAlert: Bool = false
    var userdb = Firestore.firestore().collection("Users")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
                VStack {
            HStack {
                Text("Change Order")
                    .font(Font.custom("Microsoft Tai Le", size: 23))
                    .bold()
                    .underline()
                Spacer()
                Text(form.dateStr())
                    .font(Font.custom("Microsoft Tai Le", size: 23))
            }.padding([.leading, .top, .trailing])
            
            Spacer()
            VStack {
                HTMLView(html: form.htmlData).alert(isPresented: self.$showAlert, content: {
                                                        Alert(title: Text("Form Signed"), message: Text("This change order form was successfully signed."),
                                                              dismissButton:  .cancel(Text("Ok")){self.back()}
                                                        )})
                VStack(alignment: .leading) {
                    Spacer()
                   
                    if !isNewlySigned
                    {
                        if !form.signed{
                            Button(action: {
                                SignForm() { success in
                                    if success {
                                        //form.signed = true
                                    }
                                    else {
                                        //Error
                                    }
                                }
                            }){ Text("Sign Form").padding([.top, .bottom], 12.0)
                                .padding([.leading, .trailing], 30)}
                                .background(Color.gray)
                                .foregroundColor(Color.white)
                                .cornerRadius(9)
                        }
                    }
                    ZStack{
                        Image("signHereField")
                        if isSigned
                        {
                            Text(form.signedname).font(Font.custom("Snell Roundhand", size: 40))
                            .offset(x: -1, y: 5).scaledToFit()
                        }
                        if isNewlySigned
                        {
                            Text(signedname).font(Font.custom("Snell Roundhand", size: 40))
                            .offset(x: -1, y: 5).scaledToFit()
                        }
                        
                    }
                    Spacer()
                }
            }.padding()
            
            Spacer()
                }.onAppear(){isSigned = form.signed}
    }
    
    func SignForm(completion:@escaping ((Bool) -> ())) {
        getUser(){user in
            self.signedname = user.FirstName + " " + user.LastName
            if signedname.count > 12
            {
                if user.LastName.count < 10
                {
                    signedname = user.FirstName[0] + ". " + user.LastName
                }
                else
                {
                    signedname = user.FirstName[0] + ". " + user.LastName[0] + "."
                }
            }
            isNewlySigned = true
        var ref = Firestore.firestore().collection("Projects").document(projectID).collection("Forms").document(form.fireID)
        
        ref.updateData([
            "signed": true,
            "signedname": signedname
        ]) { err in
            if let err = err {
                vm.getProjects()
                completion(false)
            }
            else {
                self.showAlert = true
                completion(true)
            }
        }
        }
    }
    
    func back()
    {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func getUser(completion: @escaping((User)->()))
    {
        var empty = [String]()
            empty.append("")
        var user = User(firstname: "", lastname: "", phoneNumber: "", emailAddress: "", projects: empty)
            let userEmail = Auth.auth().currentUser?.email
                userdb.whereField("users_email", isEqualTo: userEmail).getDocuments{
                QuerySnapshot, error in
                for document in QuerySnapshot!.documents
                {
                    let first = document.data()["users_firstname"] as? String ?? ""
                    let last = document.data()["users_lastname"] as? String ?? ""
                    let phone = document.data()["users_phone"] as? String ?? ""
                    let email = document.data()["users_email"] as? String ?? ""
                    var userProjects = document.data()["projects"] as? [String]
                    user = User(firstname: first, lastname: last, phoneNumber: phone, emailAddress: email, projects: userProjects ?? empty)
                    completion(user)
                }
        
               
            }
    }
   
    
}

/*struct SignFormPage_Previews: PreviewProvider {
    static var form = ChangeOrderForm(title: "A title")
    static var previews: some View {
        SignFormPage(form: form, projectID: "", vm: vm)
            //.previewLayout(.fixed(width: 1334 / 2.0, height: 750 / 2.0))
            //.previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}*/
