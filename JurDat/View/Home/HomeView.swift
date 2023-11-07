//
//  HomeView.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 01.11.23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = CaseViewModel()
    @State var userName = "Wangu"
    
    var body: some View {
        VStack {
            HStack {
                Text("Hi, \(userName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            
                Spacer()
                
                Image("profilePicture")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .cornerRadius(20)
            }
            
            ScrollView {
                ForEach(vm.lawsuits) { suit in
                    if suit.lawsuitName == "Favoriten" {
                        lawsuitCard(suit: suit)
                    } else {
                        CaseHeader(suit: suit)
                        lawsuitCard(suit: suit)
                    }
                }
                
                plusButton
                    .padding(.top, 30)
            }
            
            Spacer()
            
        }
        .padding()
    }
    
    var plusButton: some View {
        ZStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                ZStack {
                    Circle()
                        .fill(.accent)
                        
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            })
            .frame(width: 60, height: 60)
        }
    }
}

struct CaseHeader: View {
    let suit: lawsuit
    var body: some View {
        VStack {
            HStack {
                Text(suit.lawsuitName)
                    .font(.title3)
                    .fontWeight(.medium)
                Spacer()
            }
            Divider()
        }
    }
}

struct lawsuitCard: View {
    
    let suit: lawsuit
    
    var body: some View {
        HStack {
            Spacer()
            Text(suit.lawsuitName)
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Divider()
                .padding()
            Spacer()
            VStack {
                Text("\(suit.fileNumbers.count)")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Fälle")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .frame(height: 125)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.accent)
        }
        
    }
}

#Preview {
    HomeView()
}
