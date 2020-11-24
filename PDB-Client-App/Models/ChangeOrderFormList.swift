//
//  ChangeOrderFormList.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/19/20.
//

import Foundation
import SwiftUI

class ChangeOrderFormList: ObservableObject {
    @Published var forms: [ChangeOrderForm]
    
    init(forms: [ChangeOrderForm]) {
        self.forms = forms
    }
}
