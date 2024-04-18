//
//  SignUpPhotoView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 02.02.24.
//

import SwiftUI
import PhotosUI
import Firebase

struct SignUpPhotoView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var email: SignInEmailViewModel
    @EnvironmentObject var auth: AuthenticationViewModel
    @EnvironmentObject var user: SettingsViewModel
    @State private var showError: Bool = false
    @State private var error: Error? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.theme.primaryPurple)
                            
                        VStack {
                            Spacer()
                            photoPicker
                        }
                        .padding()
                    }
                    .offset(y: -UIScreen.main.bounds.height * 0.5)
                    
                    Spacer()
                    
                    NavigationLink {
                        SignUpNameView()
                    } label: {
                        PurpleButton(buttonName: "Weiter")
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
                            .foregroundStyle(Color.white)
                    })
                }
            }
            .alert(error?.localizedDescription ?? "Ein Fehler ist aufgetreten", isPresented: $showError) {
                Button("OK") {
                    
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    var photoPicker: some View {
        ZStack {
            PhotosPicker(selection: $selectedItem) {
                if let urlString = user.user?.profileImagePath, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 200)
                    }
                } else {
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
            .background {
                Circle()
                    .foregroundStyle(Color.theme.primaryPurple.opacity(0.2))
            }
//            .offset(y: 40)
        }
    }
}


#Preview {
    SignUpPhotoView()
}
