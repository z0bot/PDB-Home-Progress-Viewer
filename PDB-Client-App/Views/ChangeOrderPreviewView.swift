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
        Text(form.title)
    }
}

struct ChangeOrderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeOrderPreviewView(form: ChangeOrderForm(title: "A form", description: "A description"))
    }
}
