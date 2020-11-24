//
//  PanoramaView.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 11/22/20.
//

import SwiftUI
import UIKit
import CTPanoramaView

struct PanoramaView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    let image: UIImage
    
    func makeUIView(context: Context) -> some UIView {
        
        let pano = CTPanoramaView(frame: CGRect(x: 0, y: 0, width: 200, height: 300), image: image)
        
        pano.panoramaType = .spherical
        
        return pano
    }
}

struct PanoramaView_Previews: PreviewProvider {
    static var previews: some View {
        PanoramaView(image: UIImage())
    }
}
