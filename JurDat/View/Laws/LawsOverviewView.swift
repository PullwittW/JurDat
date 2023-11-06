//
//  LawsOverviewView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 06.11.23.
//

import SwiftUI

struct LawsOverviewView: View {
    
    @StateObject var vm = LawBookViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                lawBooksFavorites(lawBookName: "Bürgerliches Gesetzbuch")
                lawBooksFavorites(lawBookName: "Grundgesetz")
            }
            
            HStack {
                lawBooksFavorites(lawBookName: "Bürgerliches Gesetzbuch")
                lawBooksFavorites(lawBookName: "Bürgerliches Gesetzbuch")
            }
            
            
            ScrollView {
                ForEach(vm.lawBooks) { book in
                    Text(book.title)
                }
            }
        }
        .onAppear {
            vm.loadLawBooks()
        }
    }
}

struct lawBooksFavorites: View {
    
    var lawBookName: String
    
    var body: some View {
        VStack {
            Text(lawBookName)
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke()
                        .frame(height: 50)
            }
        }
        .padding(10)
    }
}


#Preview {
    LawsOverviewView()
}
