//
//  SignInNameView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 15.01.24.
//

import SwiftUI

struct SignUpNameView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Vorname", text: $email.userSurname)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            TextField("Nachname", text: $email.userLastname)
                .textFieldStyle(.plain)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            Spacer()
            NavigationLink {
                SignUpPasswordView()
            } label: {
                PurpleButton(buttonName: "Weiter")
            }
            Spacer()
        }
    }
}
