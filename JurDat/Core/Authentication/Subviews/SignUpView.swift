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
    @StateObject private var vm = SignInEmailViewModel()
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    textFields
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
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
        .alert(error?.localizedDescription ?? "Ein Fehler ist aufgetreten", isPresented: $showError) {
            Button("OK") {
                
            }
        }
    }
    
    var circleView: some View {
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
                if vm.userEmail.count <= 0 || vm.userPassword.count <= 0 {
                    let customeError: Error = MyCustomError.noCredentials
                    error = customeError
                    showError.toggle()
                } else {
                    vm.signUp()
                    dismiss()
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

#Preview {
    SignUpView()
}
