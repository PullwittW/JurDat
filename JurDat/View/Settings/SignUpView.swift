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
    
    var body: some View {
        NavigationStack {
            VStack {
                textFields
    //            ZStack {
    //                cicleView
    //                    .offset(y: 250)
    //            }
            }
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
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                if authUser != nil {
                    dismiss()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
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
    
//    var googleButton: some View {
//        
//    }
}

#Preview {
    SignUpView()
}
