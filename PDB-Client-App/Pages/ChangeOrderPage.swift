//
//  ChangeOrderPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/30/20.
//

import SwiftUI
import ASCollectionView

struct ChangeOrderPage: View {
    @Binding var project: Project
    
    var body: some View {
        ASCollectionView(data: project.changeOrderForms!.indices, dataID: \.self) { index,arg  in
            
            NavigationLink(destination:
                            SignFormPage(form: (project.changeOrderForms?[index])!)
            ) {
                ChangeOrderPreviewView(form: (project.changeOrderForms?[index])!)
            }
            .padding([.top])
            
        }.layout {
            .grid()
        }.background(Color("backgroundColor"))
    }
}

/*struct ChangeOrderPage_Previews: PreviewProvider {
    static var formsArr = [ChangeOrderForm(title: "Marble Counter", description: "Changing counter to marble")]
    static var previews: some View {
        ChangeOrderPage(forms: forms)
    }
}*/
