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
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: UserViewModel
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.theme.purple)
                        
                    VStack {
                        Spacer()
                        textFields
                    }
                    .padding()
                }
                .offset(y: -UIScreen.main.bounds.height * 0.5)
                
                
                VStack {
                    Spacer()
                    signInGoogleButton
                        .padding(.bottom)
                    signInEmailButton
                    HStack {
                        Text("Du hast noch keinen Accout?")
                        NavigationLink("Registrieren") {
                            SignUpView()
                        }
                        .bold()
                        .foregroundStyle(Color.accent)
                    }
                }
                .padding()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {dismiss()}, label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                })
            }
        }
        .alert(error?.localizedDescription ?? "Ein Fehler ist aufgetreten", isPresented: $showError) {
            Button("OK") {
                
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    var textFields: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email.userEmail)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .keyboardType(.emailAddress)
            
            SecureField("Passwort", text: $email.userPassword)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        }
    }
    
    var signInEmailButton: some View {
        VStack {
            Button(action: {
                if email.userEmail.isEmpty || email.userPassword.isEmpty {
                    let customeError: Error = MyCustomError.noCredentials
                    error = customeError
                    showError.toggle()
                } else if email.userEmail.count <= 0 || email.userPassword.count <= 0{
                    let customeError: Error = MyCustomError.wrongCredentals
                    error = customeError
                    showError.toggle()
                } else {
                    email.singIn()
                    Task {
                        try? await user.loadCurrentUser()
                    }
                    dismiss()
                }
            }, label: {
                PurpleButton(buttonName: "Sign In")
            })
        }
    }
    
    var signInGoogleButton: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
            Task {
                do {
                    try await auth.signInGoogle()
                } catch {
                    print(error)
                }
            }
        }
    }
}

#Preview {
    SignInView()
}
