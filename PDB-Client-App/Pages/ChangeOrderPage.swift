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
    
    var body: some View {
        ASCollectionView(data: forms.indices, dataID: \.self) { index,arg  in
            
            NavigationLink(destination:
                            SignFormPage(form: forms[index])
            ) {
                Text(forms[index].title + (forms[index].signed ? "sig" : "notsig"))
            }.navigationBarHidden(true)
            .padding([.top])
            
        }.layout {
            .grid()
        }.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray,
                        lineWidth: 1)
        )
    }
}

struct ChangeOrderPage_Previews: PreviewProvider {
    static var formsArr = [ChangeOrderForm(title: "Marble Counter", description: "Changing counter to marble")]
    static var previews: some View {
        ChangeOrderPage(forms: formsArr)
    }
}
