//
//  ChangeOrderPreviewView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/31/20.
//

import SwiftUI

struct ChangeOrderPreviewView: View {
    var form: ChangeOrderForm
    
    var body: some View {
        VStack {
            if(!form.signed) {
                Image("alert")
                    .offset(x: 75, y: 30)
                    .zIndex(1.1)
            }
            Image("ChangeOrderFormPreviewTemp")
            Text(form.title)
                .font(Font.custom("Microsoft Tai Le", size: 23))
        }
    }
}

struct ChangeOrderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeOrderPreviewView(form: ChangeOrderForm(title: "A form"))
    }
}
