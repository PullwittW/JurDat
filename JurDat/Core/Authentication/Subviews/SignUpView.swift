//
//  LogInView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
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
                .offset(y: -UIScreen.main.bounds.height * 0.3)
                
                VStack {
                    Spacer()
                    signUpEmailButton
                    HStack {
                        Text("Du hast noch keinen Accout?")
                        Text("Sign In")
                            .onTapGesture {
                                dismiss()
                            }
                            .bold()
                            .foregroundStyle(Color.theme.purple)
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
            TextField("Vorname", text: $email.userSurname)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            TextField("Nachname", text: $email.userLastname)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
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
    
    var signUpEmailButton: some View {
        VStack {
            Button(action: {
                if email.userEmail.count <= 0 || email.userPassword.count <= 0 {
                    let customeError: Error = MyCustomError.noCredentials
                    error = customeError
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
    SignUpView()
}
