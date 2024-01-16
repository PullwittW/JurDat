//
//  SignInEmailView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignInEmailView: View {
    
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
            PurpleButton(buttonName: "Weiter")
            Spacer()
            
        }
    }
}

#Preview {
    SignInEmailView()
}
