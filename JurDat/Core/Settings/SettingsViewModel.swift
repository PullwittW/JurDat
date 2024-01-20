//
//  SettingsViewModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 12.11.23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    @Published var userLawsuits: [Lawsuit] = []
    @Published private(set) var user: DBUser? = nil
    @Published var userIsLoggedIn: Bool = false
    @Published var allDataValid: Bool = false
    @Published var userSurname = ""
    @Published var userLastname = ""
    
// MARK: Load user data
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
        print("LOADING AUTH USER...")
        userIsLoggedIn = true
        self.userLawsuits = user?.lawsuits ?? []
    }
    
    func loadAuthProviders() {
        if let providers = try? AuthenticationManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func getUserData() async throws -> AuthDataResultModel {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        return authUser
    }
    
// MARK: User
    func setUserSurname() async throws {
        guard let user else { return }
        try await UserManager.shared.setUserSurname(userId: user.userId, surname: userSurname)
        self.user = try await UserManager.shared.getUser(userId: user.userId)
    }
    
    func setUserLastname() async throws {
        guard let user else { return }
        try await UserManager.shared.setUserLastname(userId: user.userId, lastname: userLastname)
        self.user = try await UserManager.shared.getUser(userId: user.userId)
    }
    
    
// MARK: User Email Settings
    
    func updateEmail() async throws {
        let email = "olaf.scholz@ampel.de"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else {
            throw URLError(.fileIsDirectory)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let password = "password1"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
    
    func signOut() throws {
        try AuthenticationManager.shared.singOut()
        user = nil
        userIsLoggedIn = false
    }
    
    func deleteUser() async throws {
        try await AuthenticationManager.shared.deleteUser()
        userIsLoggedIn = false
    }
    
// MARK: User Case Favoriten
    
    // Hinzufügen von Favorisierten Gerichtsentscheidungen (View noch erstellen)
    func addUserFavoriteCase(caseID: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.addUserFavoriteCases(userId: user.userId, favoriteCaseID: caseID)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeUserFavoiteCase(caseID: String) {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeUserFavoriteCases(userId: user.userId, favoriteCaseID: caseID)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
// MARK: User Lawsuits
    
    func addLawsuit(lawsuit: Lawsuit) {
        guard let user else { return }
        Task {
            try await UserManager.shared.addLawsuit(userId: user.userId, lawsuit: lawsuit)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
        self.userLawsuits.append(lawsuit)
    }
    
    func removeLawsuit(lawsuit: Lawsuit) {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeLawsuit(userId: user.userId, lawsuit: lawsuit)
            print("Removing lawsuit: \(lawsuit)")
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func addCaseToLawsuit(lawsuit: Lawsuit, caseItem: Case) {
        guard let user else { return }
        var cases = lawsuit.fileNumbers
        cases.append(caseItem.fileNumber)
        Task {
            try await UserManager.shared.addCaseToLawsuit(userId: user.userId, newLawsuit: Lawsuit(lawsuitName: lawsuit.lawsuitName, lawsuitDescription: lawsuit.lawsuitDescription ?? "", fileNumbers: cases), oldLawsuit: lawsuit)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
// MARK: User News
    func addNews(news: News) {
        guard let user else { return }
        Task {
            try await UserManager.shared.addUserFavoriteNews(userId: user.userId, news: news)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func removeNews(news: News) {
        guard let user else { return }
        Task {
            try await UserManager.shared.removeUserFavoriteNews(userId: user.userId, news: news)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
//    func addNewsToLawsuit(lawsuit: Lawsuit, newsItem: News) {
//        guard let user else { return }
//        var news = lawsuit.newsNumbers
//        news.append(newsItem.titel)
//        Task {
//            try await UserManager.shared.addCaseToLawsuit(userId: user.userId, newLawsuit: Lawsuit(lawsuitName: lawsuit.lawsuitName, lawsuitDescription: lawsuit.lawsuitDescription ?? "", fileNumbers: lawsuit.fileNumbers, newsNumbers: news), oldLawsuit: lawsuit)
//            self.user = try await UserManager.shared.getUser(userId: user.userId)
//        }
//    }
}
