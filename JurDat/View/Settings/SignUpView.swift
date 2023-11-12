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
    @StateObject private var vm = UserViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationStack {
            if showSignInView {
                VStack {
                    textFields
        //            ZStack {
        //                cicleView
        //                    .offset(y: 250)
        //            }
                }
            }
        }
        .navigationBarBackButtonHidden()
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
    
    var cicleView: some View {
        ZStack {
            Circle()
                .fill(.accent)
                .frame(width: 700, height: 700)
        }
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
            
            Button(action: {
                vm.singUp()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    if authUser != nil {
                        showSignInView = false
                        dismiss()
                    }
                }
            }, label: {
                PurpleButton(buttonName: "Sign Up")
            })
            
            HStack {
                Text("Alredy have an account?")
                Text("Sign In")
                    .onTapGesture {
                        dismiss()
                    }
                    .bold()
                    .foregroundStyle(Color.accent)
            }
        }
        .padding()
    }
}
