//
//  SignUpLastName.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 19.01.24.
//

import SwiftUI

struct SignUpLastName: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    @State private var successFeedback: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.theme.purple)
                            
                        VStack {
                            Spacer()
                            TextField("Dein Nachname", text: $user.userLastname)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        }
                        .padding()
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.5)
                    
                    Spacer()
                    
                    signUpEmailButton
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarBackButtonHidden()
            .sensoryFeedback(.success, trigger: successFeedback)
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
    }
    
    var signUpEmailButton: some View {
        VStack {
            Button(action: {
                Task {
                    try await user.loadCurrentUser()
                    try await user.setUserLastname()
                    try await user.setUserSurname()
                }
                email.userEmail = ""
                email.userPassword = ""
                user.allDataValid = true
                successFeedback.toggle()
                dismiss()
            }, label: {
                PurpleButton(buttonName: "Registrieren")
            })
        }
        .padding()
    }
}

#Preview {
    SignUpLastName()
}
