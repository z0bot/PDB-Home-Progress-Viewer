//
//  LoginPage.swift
//  PDB-Client-App
//
//  Created by Blake Cox on 10/27/20.
//

import SwiftUI

struct LoginPage: View {
    
    var body: some View {
        GeometryReader{ Geometry in
            VStack(alignment: .center) {
                Image("Logowithname")
                VStack(alignment: .center){
                    TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    Divider()
                    TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    Divider()
                    Spacer()
                    Button(action: {}){
                        Text("Login").padding(5)
                    }.background(Color.gray).foregroundColor(Color.white).cornerRadius(5)
                }.padding(40)
            
                
                
            
            VStack(alignment: .center){
                Image("triangle").aspectRatio(contentMode: .fit)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                    maxHeight: .infinity, alignment: .bottom)
        
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,
                maxHeight: .infinity)
        }
    }
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
