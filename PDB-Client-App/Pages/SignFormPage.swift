//
//  SignFormPage.swift
//  PDB-Client-App
//
//  Created by Ben Cramer on 10/31/20.
//

import SwiftUI

struct SignFormPage: View {
    var form: ChangeOrderForm
    var body: some View {
        
        VStack {
            HStack {
                Text("Change Order")
                    .font(Font.custom("Microsoft Tai Le", size: 23))
                    .bold()
                    .underline()
                Spacer()
                Text(form.dateString())
                    .font(Font.custom("Microsoft Tai Le", size: 23))
            }.padding([.leading, .top, .trailing])
            
            HStack {
                Text(form.description)
                    .font(Font.custom("Microsoft Tai Le", size: 23))
                
                Spacer()
            }.padding([.leading, .bottom, .trailing])
            
            HStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Previous")
                            .bold()
                            .font(Font.custom("Microsoft Tai Le", size: 23))
                        
                        Text("Update")
                            .font(Font.custom("Microsoft Tai Le", size: 23))
                            .bold()
                    }
                    HStack(alignment: .top) {
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Item")
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                                .bold()
                            
                            Text("Item Price")
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                                .bold()
                            Text("House Estimate")
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                                .bold()
                        }
                        VStack {

                            
                            Text(form.oldItem)
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                            
                            Text(ChangeOrderForm.FloatToDollars(num: form.oldItemPrice))
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                            
                            Text(ChangeOrderForm.FloatToDollars(num: form.oldTotalCost))
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                            
                            
                        }
                        VStack {
                            
                            Text(form.newItem)
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                            
                            Text(ChangeOrderForm.FloatToDollars(num: form.newItemPrice))
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                            
                            Text(ChangeOrderForm.FloatToDollars(num: form.newTotalCost))
                                .font(Font.custom("Microsoft Tai Le", size: 23))
                        }
                    }
                }.padding()
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Sign here")
                        .font(Font.custom("Microsoft Tai Le", size: 23))
                    
                    Rectangle()
                        .frame(width: 300, height: 120)
                }
            }.padding()
            
            Spacer()
        }.onAppear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.landscape
            
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            
            UIViewController.attemptRotationToDeviceOrientation()
        }
        .onDisappear {
            AppDelegate.orientationLock = UIInterfaceOrientationMask.portrait
            
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}

struct SignFormPage_Previews: PreviewProvider {
    static var form = ChangeOrderForm(title: "A title", description: "A description")
    static var previews: some View {
        SignFormPage(form: form)
            .previewLayout(.fixed(width: 1334 / 2.0, height: 750 / 2.0))
            //.previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
