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
    @Published var userSurname = ""
    @Published var userLastname = ""
    @Published var userEmail = ""
    @Published var userPassword = ""
    
    func signUp() {
        guard !userEmail.isEmpty, !userPassword.isEmpty, !userSurname.isEmpty, !userLastname.isEmpty else {
            print("No email or password found")
            return
        }
        Task {
            do {
                let authDataResult = try await AuthenticationManager.shared.createUser(email: userEmail, password: userPassword)
                let user = DBUser(auth: authDataResult)
                try await UserManager.shared.createNewUser(user: user)
                try await UserManager.shared.setUserSurname(userId: user.userId, surname: userSurname)
                try await UserManager.shared.setUserLastname(userId: user.userId, lastname: userLastname)

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
