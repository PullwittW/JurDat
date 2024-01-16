//
//  SignInEmailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignUpEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Email", text: $email.userEmail)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .keyboardType(.emailAddress)
            Spacer()
            NavigationLink {
                SignUpNameView()
            } label: {
                PurpleButton(buttonName: "Weiter")
            }
            Spacer()
            
        }
    }
}
