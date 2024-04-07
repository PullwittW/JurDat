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
class SignInEmailViewModel: ObservableObject {
    @Published var userEmail = ""
    @Published var userPassword = ""
//    @Published var showingLoginView: Bool = false
    
    func signUp() {
        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            print("No email or password found")
            return
        }
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.createUser(email: userEmail, password: userPassword)
                let user = DBUser(auth: authDataResult)
                try await UserManager.shared.createNewUser(user: user)
                print("Success")
                print(authDataResult)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func singIn() {
        guard !userEmail.isEmpty, !userPassword.isEmpty else {
            print("No email or password found")
            return
        }
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.signInUser(email: userEmail, password: userPassword)
                print("Success")
                print(returnedUserData)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
