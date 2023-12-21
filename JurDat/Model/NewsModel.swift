//
//  NewsModel.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import Foundation

// MARK: - NewsResult
struct NewsResult: Codable {
    let numFound: Int
    let cursor: String
    let documents: [News]?
}

// MARK: - Document
struct News: Codable, Identifiable {
    let id: String
    let abstract: String?
    let beratungsstand: String?
    let vorgangstyp: Vorgangstyp
    let gesta: String?
    let sachgebiet: [String]?
    let typ: DocumentTyp
    let wahlperiode: Int
    let zustimmungsbeduerftigkeit, initiative: [String]?
    let aktualisiert: String
    let deskriptor: [Deskriptor]?
    let titel: String
    let datum: String?
    let vorgangVerlinkung: [VorgangVerlinkung]?
    let archiv: String?
    let verkuendung: [Verkuendung]?
    let inkrafttreten: [Inkrafttreten]?

    enum CodingKeys: String, CodingKey {
        case id, abstract, beratungsstand, vorgangstyp, gesta, sachgebiet, typ, wahlperiode, zustimmungsbeduerftigkeit, initiative, aktualisiert, deskriptor, titel, datum
        case vorgangVerlinkung = "vorgang_verlinkung"
        case archiv, verkuendung, inkrafttreten
    }
}

// MARK: - Deskriptor
struct Deskriptor: Codable {
    let fundstelle: Bool
    let name: String
    let typ: DeskriptorTyp
}

enum DeskriptorTyp: String, Codable {
    case freierDeskriptor = "Freier Deskriptor"
    case geographBegriffe = "Geograph. Begriffe"
    case institutionen = "Institutionen"
    case rechtsmaterialien = "Rechtsmaterialien"
    case sachbegriffe = "Sachbegriffe"
}

// MARK: - Inkrafttreten
struct Inkrafttreten: Codable {
    let datum: String
    let erlaeuterung: String?
}

enum DocumentTyp: String, Codable {
    case vorgang = "Vorgang"
}

// MARK: - Verkuendung
struct Verkuendung: Codable {
    let jahrgang, heftnummer, ausfertigungsdatum, verkuendungsdatum: String
    let einleitungstext: String
    let pdfURL: String
    let verkuendungsblattBezeichnung, verkuendungsblattKuerzel, fundstelle: String
    let seite: String?

    enum CodingKeys: String, CodingKey {
        case jahrgang, heftnummer, ausfertigungsdatum, verkuendungsdatum, einleitungstext
        case pdfURL = "pdf_url"
        case verkuendungsblattBezeichnung = "verkuendungsblatt_bezeichnung"
        case verkuendungsblattKuerzel = "verkuendungsblatt_kuerzel"
        case fundstelle, seite
    }
}

// MARK: - VorgangVerlinkung
struct VorgangVerlinkung: Codable {
    let verweisung, titel, id: String
    let wahlperiode: Int
}

enum Vorgangstyp: String, Codable {
    case gesetzgebung = "Gesetzgebung"
}

