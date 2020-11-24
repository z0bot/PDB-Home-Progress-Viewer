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
    let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"

   func makeUIView(context: Context) -> WKWebView {
        /*let label = UILabel()
        DispatchQueue.main.async {
            let data = Data(self.html.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                label.attributedText = attributedString
            }
        }

        return label*/
        return WKWebView()
        
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(headerString + html, baseURL: nil)
    }
}

struct HTMLView_Previews: PreviewProvider {
    static var previews: some View {
        HTMLView(html: "<html> <body><p>This is an example of a simple HTML page with one paragraph.</p></body> </html>")
    }
}
