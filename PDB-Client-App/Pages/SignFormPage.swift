//
//  SignFormPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/31/20.
//

import SwiftUI
import Firebase

struct SignFormPage: View {
    var form: ChangeOrderForm
    var projectID: String
    
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
                HTMLView(html: form.htmlData)
                VStack(alignment: .leading) {
                    Spacer()
                        Text("Sign here")
                            .font(Font.custom("Microsoft Tai Le", size: 23))
                        
                        Image("signHereField")
                            
                    Spacer()
                }
                .onTapGesture(count: 1, perform: {
                    SignForm() { success in
                        if success {
                            //form.signed = true
                        }
                        else {
                            //Error
                        }
                    }
                })
            }.padding()
            
            Spacer()
        }
    }
    
    func SignForm(completion:@escaping ((Bool) -> ())) {
        if form.signed {
            return
        }
        
        var ref = Firestore.firestore().collection("Projects").document(projectID).collection("Forms").document(form.fireID)
        
        ref.updateData([
            "signed": true
        ]) { err in
            if let err = err {
                completion(false)
            }
            else {
                completion(true)
            }
        }
    }
}

struct SignFormPage_Previews: PreviewProvider {
    static var form = ChangeOrderForm(title: "A title")
    static var previews: some View {
        SignFormPage(form: form, projectID: "")
            //.previewLayout(.fixed(width: 1334 / 2.0, height: 750 / 2.0))
            //.previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
