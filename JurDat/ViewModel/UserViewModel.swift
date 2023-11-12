//
//  UserViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 10.11.23.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var userEmail = ""
    @Published var userPassword = ""
    
    func singIn() {
        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: userEmail, password: userPassword)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func userLogOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
