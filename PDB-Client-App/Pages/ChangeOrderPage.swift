//
//  ChangeOrderPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/30/20.
//

import SwiftUI
import ASCollectionView
import Firebase

struct ChangeOrderPage: View {
    @State var forms = [ChangeOrderForm]()
    var projectID: String
    @ObservedObject var vm: HomePageVM
    var db = Firestore.firestore().collection("Projects")
    
    var body: some View {
        VStack {
            ASCollectionView(data: forms.indices, dataID: \.self) { index,arg  in
                
                NavigationLink(destination:
                                SignFormPage(form: forms[index], projectID: projectID, vm: vm)
                ) {
                    ChangeOrderPreviewView(form: forms[index])
                }
                .padding([.top])
                
            }.layout {
                .grid()
            }
        }.onAppear(){self.getForms(id: projectID)}
    }
    
    func getForms(id: String) {
        forms = [ChangeOrderForm]()
        self.db.document(id).collection("Forms").getDocuments(completion:
        {
            QuerySnapshot, error in
                for document in QuerySnapshot!.documents
                {
                    let fireID = document.documentID
                    let title = document.data()["title"] as? String ?? ""
                    let dateStr = document.data()["date"] as? String ?? ""
                    let date = Date.String(from: dateStr)
                    
                    let formHTML = document.data()["html"] as? String ?? ""
                    let signed = document.data()["signed"] as? Bool ?? false
                    let signedname = document.data()["signedname"] as? String ?? ""
                    forms.append(ChangeOrderForm(fireID: fireID, title: title, date: date, htmlData: formHTML, signed: signed, signedname: signedname))
                    
                }
        })
    }
}

/*struct ChangeOrderPage_Previews: PreviewProvider {
    static var formsArr = [ChangeOrderForm(title: "Marble Counter")]
    static var previews: some View {
        ChangeOrderPage(forms: formsArr, projectID: "")
    }
}*/
