//
//  SessionStore.swift
//  PDB-Client-App
//
//  Created by bCox on 10/29/20.
//

import Foundation
import SwiftUI
import Firebase
import Combine

class SessionStore : BindableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(
                    Uid: user.Uid,
                    Name: user.Name
                )
            } else {
                // if we don't have a user, set our session to nil
                self.session = nil
            }
        }
    }

    // additfunc signUp(
    email: String,
    password: String,
    
    handler: @escaping AuthDataResultCallback
    ) {
    Auth.auth().createUser(withEmail: email, password: password, completion: handler)
}

func signIn(
    email: String,
    password: String,
    handler: @escaping AuthDataResultCallback
    ) {
    Auth.auth().signIn(withEmail: email, password: password, completion: handler)
}

func signOut () -> Bool {
    do {
        try Auth.auth().signOut()
        self.session = nil
        return true
    } catch {
        return false
    }ional methods (sign up, sign in) will go here
}
