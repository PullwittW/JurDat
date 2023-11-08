//
//  LogInView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct LogInView: View {
    
    @State var username: String = ""
    @State var userPassword: String = ""
    
    var body: some View {
        VStack {
            cicleView
        }
        .offset(y: 250)
    }
    
    var cicleView: some View {
        ZStack {
            Circle()
                .foregroundStyle(Color.purple)
                .frame(width: 700, height: 700)
            
            VStack {
                TextField("Nutzername", text: $username)
                
                TextField("Passwort", text: $userPassword)
            }
            .background {
                Rectangle()
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    LogInView()
}
