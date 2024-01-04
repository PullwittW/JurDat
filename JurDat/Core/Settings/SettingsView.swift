//
//  SettingsView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 10.11.23.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var email: SignInEmailViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = userVM.user {
                    Image("profilePicture")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Text(user.email ?? "No email found")
                        .font(.title)
                        .bold()
                    
                    ScrollView {
                        VStack {
                            // Favorisierte Cases
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Fälle")
                                        .foregroundStyle(Color("TextColor"))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                Divider()
                                
                                ForEach(userVM.user?.favoriteCases ?? ["Kein Fall favorisiert"], id: \.self) { caseItem in
                                    Text(caseItem)
                                        .padding(.bottom, 10)
                                }
                            }
                            .padding(.vertical)
                            
                            // Favorisierte News
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("News")
                                        .foregroundStyle(Color("TextColor"))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                Divider()
                                
                                ForEach(userVM.user?.favoriteNews ?? ["Keine News favorisiert"], id: \.self) { news in
                                    Text(news)
                                        .padding(.bottom, 10)
                                }
                            }
                            .padding(.bottom)
                            
                            // Email Einstellungen
                            VStack {
                                HStack {
                                    Text("Email")
                                        .foregroundStyle(Color("TextColor"))
                                        .font(.callout)
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                Divider()
                                
                                if userVM.authProviders.contains(.email) {
                                    updateEmailButton
                                    updatePasswordButton
                                    resetPasswordButton
                                        .padding(.bottom)
                                }
                                userLogOutButton
                                userDeleteButton
                            }
                        }
                    }
                    
//                    Spacer()
                    
                } else {
                    Spacer()
                    userSignInButton
                }
            }
            .padding()
            .task {
                userVM.loadAuthProviders()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {dismiss()}, label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .fontWeight(.bold)
                    })
                }
            }
            .navigationBarBackButtonHidden()
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    var userSignInButton: some View {
        NavigationLink {
            SignInView()
        } label: {
            PurpleButton(buttonName: "Sign In")
        }

    }
    
    var resetPasswordButton: some View {
        Button(action: {
            Task {
                do {
                    try await userVM.resetPassword()
                    print("PASSWORD RESET")
                } catch {
                    print(error)
                }
            }
            
        }) {
            PurpleButton(buttonName: "Passwort zurücksetzen")
        }
    }
    
    var updatePasswordButton: some View {
        Button(action: {
            Task {
                do {
                    try await userVM.updatePassword()
                    print("PASSWORD UPDATED")
                } catch {
                    print(error)
                }
            }
            
        }) {
            PurpleButton(buttonName: "Passwort ändern")
        }
    }
    
    var updateEmailButton: some View {
        Button(action: {
            Task {
                do {
                    try await userVM.updateEmail()
                    print("EMAIL UPDATED")
                } catch {
                    print(error)
                }
            }
            
        }) {
            PurpleButton(buttonName: "Email ändern")
        }
    }
    
    var userLogOutButton: some View {
        Button(action: {
            Task {
                do {
                    try userVM.signOut()
                } catch {
                    print(error)
                }
            }
        }) {
            PurpleButton(buttonName: "Log Out")
        }
    }

    var userDeleteButton: some View {
        Button(role: .destructive) {
            Task {
                do {
                    try await userVM.deleteUser()
                } catch {
                    print(error)
                }
            }
        } label: {
            Text("Account löschen")
                .font(.headline)
                .foregroundStyle(.white)
                .bold()
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .cornerRadius(10)
        }

    }
}

#Preview {
    SettingsView()
}
