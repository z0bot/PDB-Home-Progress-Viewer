//
//  AuthenticationState.swift
//  PDB-Client-App
//
//  Created by bCox on 10/29/20.
//

import Foundation
import FirebaseAuth

class AuthenticationState: NSObject, ObservableObject {

    @Published var loggedInUser: User?
    @Published var isAuthenticating = false
    @Published var error: NSError?

    static let shared = AuthenticationState()

    private let auth = Auth.auth()
    fileprivate var currentNonce: String?

    func signup(email: String, password: String, passwordConfirmation: String) {
        // TODO
    }

    private func handleSignInWith(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: handleAuthResultCompletion)
    }
    
    private func handleAuthResultCompletion(auth: AuthDataResult?, error: Error?) {
            DispatchQueue.main.async {
            self.isAuthenticating = false
                if let user = auth?.user {
                    self.loggedInUser = user
                } else if let error = error {
                    self.error = error as NSError
                }
            }
        }
    
}
