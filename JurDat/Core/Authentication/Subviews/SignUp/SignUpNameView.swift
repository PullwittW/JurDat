//
//  SignInNameView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignUpNameView: View {
    
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
                            .foregroundStyle(Color.theme.primaryPurple)
                            
                        VStack {
                            Spacer()
                            TextField("Dein Vorname", text: $user.userSurname)
                                .textFieldStyle(.plain)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                        }
                        .padding()
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.5)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpLastName()
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
//            .onDisappear(perform: {
//                user.setUserSurname(surname: email.userSurname)
//            })
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
    }
}
