//
//  SettingsView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 10.11.23.
//

import SwiftUI
import Firebase
import PhotosUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userVM: SettingsViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var email: SignInEmailViewModel
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var url: URL? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                if let user = userVM.user {
                    
                    if let urlString = userVM.user?.profileImagePath, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                                .frame(width: 100, height: 100)
                        }
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .padding()
                            .background {
                                Circle()
                                    .foregroundStyle(Color.theme.textColor)
                            }
                    }
                    
                    PhotosPicker(selection: $selectedItem) {
                        Text("Profilbild ändern")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.theme.textColor)
                    }
                    
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
                    VStack {
                        Spacer()
                        Text("JurDat.")
                            .foregroundStyle(Color.theme.purple)
                            .font(.custom("Kadwa-Bold", size: 63))
                        Spacer()
                        VStack(alignment: .leading, spacing: 40) {
                            HStack {
                                Image(systemName: "hammer.fill") // "hammer"
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .padding(.trailing)

                                Text("Erhalte Zugriff auf aktuelle Gerichtsentscheidungen")
                            }
                            Divider()
                            HStack {
                                Image(systemName: "text.book.closed.fill") // "lawBookIcon2"
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .padding(.trailing)

                                Text("Die 'Gesetze'-Überscht bietet dir aktelle Gesetzestexte")
                            }
                            Divider()
                            HStack {
                                Image(systemName: "newspaper")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                    .padding(.trailing)
            
                                Text("Beschlüsse und Entscheidungen des Bundestags kannst du in der 'News'-Übersicht einsehen")
                            }
                        }
                        .foregroundStyle(Color.theme.textColor)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .frame(height: 400)
                        Spacer()
                        userSignUpButton
                            .padding(.bottom, 5)
                        HStack {
                            Text("Du hast schon einen Account?")
                                .foregroundStyle(Color.theme.textColor)
                            NavigationLink("Anmelden") {
                                SignInView()
                            }
                            .bold()
                            .foregroundStyle(Color.theme.purple)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle(userVM.user?.email ?? "")
            .navigationBarBackButtonHidden()
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
            .onChange(of: selectedItem, perform: { newValue in
                if let newValue {
                    userVM.saveProfileImage(item: newValue)
                }
            })
            
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    var userSignUpButton: some View {
        NavigationLink {
            SignUpEmailView()
        } label: {
            PurpleButton(buttonName: "Registrieren")
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
            userVM.allDataValid = false
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
