//
//  SignInPasswordView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignInPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        VStack {
            Spacer()
            SecureField("Passwort", text: $email.userPassword)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            Spacer()
            signUpEmailButton
            Spacer()
        }
    }
    
    var signUpEmailButton: some View {
        VStack {
            Button(action: {
                if email.userEmail.count <= 0 || email.userPassword.count <= 0 {
                    let customError: Error = customError.noCredentials
                    error = customError
                    showError.toggle()
                } else {
                    email.signUp()
                    dismiss()
                }
            }, label: {
                PurpleButton(buttonName: "Sign Up")
            })
        }
    }
}

#Preview {
    SignInPasswordView()
}
