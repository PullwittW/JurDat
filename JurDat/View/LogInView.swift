//
//  LogInView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct LogInView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = UserViewModel()
    
    var body: some View {
        VStack {
            textFields
//            ZStack {
//                cicleView
//                    .offset(y: 250)
//            }
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
                vm.singIn()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                    if authUser != nil {
                        dismiss()
                    }
                }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .bold()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accent)
                    }
            })
            
            HStack {
                Text("Alredy have an account?")
                Button(action: {}, label: {
                    Text("Log In")
                        .bold()
                })
            }
        }
        .padding()
    }
    
//    var googleButton: some View {
//        
//    }
}

#Preview {
    LogInView()
}
