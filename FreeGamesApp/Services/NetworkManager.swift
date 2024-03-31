//
//  NetworkManager.swift
//  FreeGamesApp
//
//  Created by Никита Тыщенко on 27.03.2024.
//

import Foundation

enum Link {
    case freeGamesURL
    
    var url: URL {
        switch self {
        case .freeGamesURL:
            return URL(string: "https://www.freetogame.com/api/games")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchFreeGames(from url: URL, completion: @escaping(Result<[Game], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: Link.freeGamesURL.url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let games = try decoder.decode([Game].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(games))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
