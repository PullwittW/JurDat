//
//  ErrorHandler.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 07.12.23.
//

import Foundation

enum customError: Error, LocalizedError {
    case noInternetConnection
    case noCredentials
    case wrongCredentals
    case noLawsuitName
    case unableToLoadUser
    case unableToLoadCases
    case unableToLoadNews
    case unableToLoadLaws
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "Bitte überprüfe deine Internetverbindung und versuche es erneut."
        case .noCredentials:
            return "Bitte gib deine Anmeldedaten ein."
        case .noLawsuitName:
            return "Bitte gib einen Namen ein"
        case .wrongCredentals:
            return "Bitte gib valide Anmeldedaten ein."
        case .unableToLoadUser:
            return "Bitte melde dich mit deinem Profil an."
        case .unableToLoadCases:
            return "Es gab einen Fehler beim Laden der aktuellen Fälle."
        case .unableToLoadLaws:
            return "Es gab einen Fehler beim Laden der aktuellen Gesetzbücher."
        case .unableToLoadNews:
            return "Es gab einen Fehler beim Laden der News."
            
        } 
    }
}
