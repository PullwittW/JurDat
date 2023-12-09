//
//  SignIn.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct SignInView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = SignInEmailViewModel()
    @StateObject private var authVM = AuthenticationViewModel()
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.theme.purple)
                        
                    VStack {
                        Spacer()
                        textFields
                    }
                    .padding()
                }
                .offset(y: -UIScreen.main.bounds.height * 0.5)
                
                
                VStack(spacing: 30) {
                    Spacer()
                    signInEmailButton
                        .padding(.top)
                    signInGoogleButton
                }
                .padding()
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
    
    var textFields: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $vm.userEmail)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            
//            Rectangle()
//                .frame(width: 350, height: 1)
//                .foregroundStyle(Color.white)
            
            SecureField("Passwort", text: $vm.userPassword)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            
//            Rectangle()
//                .frame(width: 350, height: 1)
//                .foregroundStyle(Color.white)
        }
    }
    
    var signInEmailButton: some View {
        VStack {
            Button(action: {
                if vm.userEmail.isEmpty || vm.userPassword.isEmpty {
                    let customeError: Error = MyCustomError.noCredentials
                    error = customeError
                    showError.toggle()
                } else if vm.userEmail.count <= 0 || vm.userPassword.count <= 0{
                    let customeError: Error = MyCustomError.wrongCredentals
                    error = customeError
                    showError.toggle()
                } else {
                    vm.singIn()
                    dismiss()
                }
            }, label: {
                PurpleButton(buttonName: "Sign In")
            })
            
            HStack {
                Text("Du hast noch keinen Accout?")
                NavigationLink("Registrieren") {
                    SignUpView()
                }
                .bold()
                .foregroundStyle(Color.accent)
            }
            .padding(.top)
        }
    }
    
    var signInGoogleButton: some View {
        GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
            Task {
                do {
                    try await authVM.signInGoogle()
                } catch {
                    print(error)
                }
                
            }
        }
    }
    
    var circleView: some View {
        ZStack {
            Circle()
                .fill(.accent)
        }
    }
}

#Preview {
    SignInView()
}
