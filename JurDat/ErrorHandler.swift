//
//  ErrorHandler.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 07.12.23.
//

import Foundation

enum MyCustomError: Error, LocalizedError {
    case noInternetConnection
    case noCredentials
    case wrongCredentals
    case noUser
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Bitte überprüfe deine Internetverbindung und versuche es erneut."
        case .noCredentials:
            return "Bitte gib deine Anmeldedaten ein."
        case .wrongCredentals:
            return "Bitte gib valide Anmeldedaten ein."
        case .noUser:
            return "Bitte melde dich mit deinem Profil an."
        }
    }
}
