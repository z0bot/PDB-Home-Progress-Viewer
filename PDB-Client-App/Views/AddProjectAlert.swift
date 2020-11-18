//
//  AddProjectAlert.swift
//  PDB-Client-App
//
//  Created by bCox on 11/17/20.
//

import SwiftUI

struct AddProjectAlert: View {
    
    @Binding var isShown: Bool
    @Binding var projectCode: String
    var title: String = "Add Home"
    var body: some View {
        VStack {
        Text(title)
        }
    }
}

struct AddProjectAlert_Previews: PreviewProvider {
    static var previews: some View {
        AddProjectAlert(isShown: .constant(true), projectCode: .constant(""))
    }
}
