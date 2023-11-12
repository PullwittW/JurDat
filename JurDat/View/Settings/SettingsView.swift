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
                userLogOutButton
            }
            .padding()
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
        }, label: {
            Text("Ausloggen")
                .foregroundStyle(.white)
                .padding()
        })
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.accent)
        }
    }
}

#Preview {
    SettingsView(showSignInView: .constant(false))
}
