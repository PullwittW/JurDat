//
//  NewsVM.swift
//  JurDat
//
//  Created by Wangu Pullwitt on 27.11.23.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    
    @Published var news: [News] = []
    @Published var singleNews: [News] = []
    
    // URL: https://search.dip.bundestag.de/api/v1/vorgang?f.metatyp=Gesetze&f.format=json&apikey=rgsaY4U.oZRQKUHdJhF9qguHMkwCGIoLaqEcaHjYLF
    // https://search.dip.bundestag.de/api/v1/vorgang?f.vorgangstyp=Gesetzgebung&format=json&apikey=rgsaY4U.oZRQKUHdJhF9qguHMkwCGIoLaqEcaHjYLF
    // https://search.dip.bundestag.de/api/v1/vorgang?f.titel=GesetzzudemÃœbereinkommenvom12.MÃ¤rz2019zurGrÃ¼ndungdes\"SquareKilometreArray\"-Observatoriums&f.vorgangstyp=Gesetzgebung&format=json&apikey=rgsaY4U.oZRQKUHdJhF9qguHMkwCGIoLaqEcaHjYLF
    
    func loadNews() async throws {
        print("LOADING NEWS")
        let token = "rgsaY4U.oZRQKUHdJhF9qguHMkwCGIoLaqEcaHjYLF"
        guard let url = URL(string: "https://search.dip.bundestag.de/api/v1/vorgang?f.vorgangstyp=Gesetzgebung&format=json&apikey=\(token)") else { return }
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS LOADING NEWS")
                } else if 100..<200 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("INFORMAL RESPONSE")
                } else if 300..<400 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("REDIRECTION ERROR")
                } else if 400..<500 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("CLIENT ERROR")
                } else if 500..<600 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SERVER ERROR")
                } else {
                    print(response)
                }
                
                let newsResult = try JSONDecoder().decode(NewsResult.self, from: data)
                news.self = newsResult.documents ?? []
                print("News Count: \(self.news.count)")
                
            } catch {
                print(error)
            }
        }
    }
    
    func loadSpecificNews(titel: String) async throws {
        print("LOADING NEWS")
        let token = "rgsaY4U.oZRQKUHdJhF9qguHMkwCGIoLaqEcaHjYLF"
        guard let url = URL(string: "https://search.dip.bundestag.de/api/v1/vorgang/f.titel=\(titel)?f.vorgangstyp=Gesetzgebung&format=json&apikey=\(token)") else { return }
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                if 200..<300 ~= (response as? HTTPURLResponse)?.statusCode ?? 0 {
                    print("SUCCESS LOADING NEWS")
                } else {
                    print(response)
                }
                let newsResult = try JSONDecoder().decode(NewsResult.self, from: data)
                singleNews.self = newsResult.documents ?? []
                print("News Count: \(self.news.count)")
                
            } catch {
                print(error)
            }
        }
    }
    
    func formattedDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Das Eingabeformat
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "dd.MM.yyyy" // Das Ausgabeformat
            return dateFormatter.string(from: date)
        } else {
            return "Ungültiges Datum"
        }
    }
    
    func filterNews(searchText: String) -> [News] {
        if searchText.isEmpty {
                    return news
                } else {
                    return news.filter {
                        $0.titel.contains(searchText)
                    }
                }
    }
}
