//
//  HTMLView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/17/20.
//

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {

   let html: String

   func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        let label = UILabel()
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }

        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {}
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(html: "<html> <body><p>This is an example of a simple HTML page with one paragraph.</p></body> </html>")
    }
}
