//
//  SignIn.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = UserViewModel()
    @StateObject private var authVM = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                textFields
                signInEmailButton
                    .padding(.top)
                Spacer()
                signInGoogleButton
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
    }
    
    var textFields: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $vm.userEmail)
                .textFieldStyle(.plain)
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(Color.accent)
            
            SecureField("Passwort", text: $vm.userPassword)
                .textFieldStyle(.plain)
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(Color.accent)
        }
    }
    
    var signInEmailButton: some View {
        VStack {
            Button(action: {
                vm.singIn()
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                if authUser != nil {
                    dismiss()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    
                }
            }, label: {
                PurpleButton(buttonName: "Sign In")
            })
            
            HStack {
                Text("Don't have an account yet?")
                NavigationLink("Sign Up") {
                    SignUpView()
                }
                .bold()
                .foregroundStyle(Color.accent)
            }
            .padding(.top)
        }
    }
    
    var signInGoogleButton: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
            Task {
                do {
                    try await authVM.signInGoogle()
                    showSignInView = false
                } catch {
                    print(error)
                }
                
            }
        }
    }
}
