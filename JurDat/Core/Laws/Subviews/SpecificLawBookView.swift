//
//  LawBook.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.01.24.
//

import SwiftUI

struct LawBookView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var lawBookVM: LawBookViewModel
    @EnvironmentObject var userVM: SettingsViewModel
    @State private var searchText: String = ""
    var lawBookTitel: String
    var lawBookID: String
    var body: some View {
        NavigationStack {
            VStack {
                if userVM.user == nil {
                    VStack {
                        Text("Um Inhalte zu sehen, logge dich ein.")
                    }
                } else {
                    if lawBookVM.singleParagraph.isEmpty {
                        VStack(spacing: 10) {
                            ProgressView()
                            Text("Lade Gesetzbuch...")
                        }
                    } else {
                        ScrollView {
                            VStack {
                                LazyVStack {
                                    ForEach(lawBookVM.filterLaws(searchText: searchText)) { paragraph in
                                        SingleParagraphView(paragraph: paragraph)
                                    }
                                }
                                .padding(.bottom, 5)
                                
//                                Button {
//                                    print(lawBookVM.selectedLawbook?.next ?? "")
//                                    Task {
//                                        try? await lawBookVM.loadMoreSpecificLawbook(url: URL(fileURLWithPath: lawBookVM.selectedLawbook?.next ?? ""))
//                                    }
//                                } label: {
//                                    Text("Mehr laden...")
//                                        .bold()
//                                        .font(.footnote)
//                                        .foregroundStyle(Color.theme.textColor)
//                                }

                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle(lawBookTitel)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
            .interactiveDismissDisabled()
            .searchable(text: $searchText, prompt: "Suche nach Paragraphen und Titeln")
            .onAppear {
                Task {
                    try? await userVM.loadCurrentUser()
                    try? await lawBookVM.loadSpecificLawbook(bookId: lawBookID)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
//                        if !newsIsFavorite {
//                            userVM.addNews(news: news)
//                            newsIsFavorite = true
//                            print("News is favorite")
//                        } else {
//                            userVM.removeNews(news: news)
//                            newsIsFavorite = false
//                            print("News is no favorite")
//                        }
                    } label: {
                        Image(systemName: "heart")
                            .resizable()
                            .fontWeight(.bold)
                    }
                    .disabled(userVM.user != nil ? false : true)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "plus")
                            .resizable()
                            .fontWeight(.bold)
                    })
                    .disabled(userVM.user != nil ? false : true)
                }
            }
        }
    }
    
    private func htmlToString(htmlString: String) -> String {
        return htmlString.html2String
    }
}

#Preview {
    LawBookView(lawBookTitel: "BGB", lawBookID: "12323")
}
