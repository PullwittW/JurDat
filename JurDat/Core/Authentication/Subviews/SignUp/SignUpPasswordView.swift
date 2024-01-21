//
//  SignInPasswordView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignUpPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.theme.purple)
                            
                        VStack {
                            Spacer()
                            SecureField("Passwort", text: $email.userPassword)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        }
                        .padding()
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.5)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpNameView()
//                        HomeView()
                    } label: {
                        PurpleButton(buttonName: "Weiter")
                    }
                    .padding()
                }
            }
            .onAppear(perform: {
                if user.allDataValid {
                    dismiss()
                }
            })
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
            .onDisappear(perform: {
                email.signUp()
            })
            .alert(error?.localizedDescription ?? "Ein Fehler ist aufgetreten", isPresented: $showError) {
                Button("OK") {
                    
                }
            }
            .ignoresSafeArea(.keyboard)
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
                PurpleButton(buttonName: "Weiter")
            })
        }
    }
}
