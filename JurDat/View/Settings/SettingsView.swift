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
    @StateObject private var vm = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                if vm.authProviders.contains(.email) {
                    listView
                }
                
                userLogOutButton
            }
            .padding()
        }
        .onAppear {
            vm.loadAuthProviders()
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
    }
    
    var listView: some View {
        List {
            Section("Email") {
                updateEmailButton
                updatePasswordButton
                resetPasswordButton
            }
        }
        .listStyle(.plain)
    }
    
    var userLogOutButton: some View {
        Button(action: {
            Task {
                do {
                    try vm.signOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
        }) {
            PurpleButton(buttonName: "Log Out")
        }
    }
    
    var resetPasswordButton: some View {
        Button(action: {
            Task {
                do {
                    try await vm.resetPassword()
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
                    try await vm.updatePassword()
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
                    try await vm.updateEmail()
                    print("EMAIL UPDATED")
                } catch {
                    print(error)
                }
            }
            
        }) {
            PurpleButton(buttonName: "Email ändern")
        }
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}
