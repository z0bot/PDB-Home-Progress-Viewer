//
//  ChangeOrderFormPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/27/20.
//

import SwiftUI

struct ChangeOrderFormPage: View {
    private var cols: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: cols,
                      spacing: 30) {
                
                ForEach(0..<13) { i in
                    NavigationLink(destination:
                                    SignFormPage()) {
                        FormPreviewView()
                    }
                }
            }
            .padding()            
        }
    }
}

struct ChangeOrderFormPage_Previews: PreviewProvider {
    static var previews: some View {
        ChangeOrderFormPage()
    }
}
