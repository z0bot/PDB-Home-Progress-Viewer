//
//  ChangeOrderPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/30/20.
//

import SwiftUI
import ASCollectionView

struct ChangeOrderPage: View {
    var forms: [ChangeOrderForm]
    var projectID: String
    @ObservedObject var vm: HomePageVM
    
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
        }
    }
}

/*struct ChangeOrderPage_Previews: PreviewProvider {
    static var formsArr = [ChangeOrderForm(title: "Marble Counter")]
    static var previews: some View {
        ChangeOrderPage(forms: formsArr, projectID: "")
    }
}*/
