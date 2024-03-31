//
//  Game.swift
//  FreeGamesApp
//
//  Created by Никита Тыщенко on 27.03.2024.
//

import Foundation

struct Game: Decodable {
    let title: String
    let thumbnail: String
    let shortDescription: String
    let gameUrl: String
    let genre: String
    let platform: String
    let developer: String
    let releaseDate: String
    
    var description: String {
        """
    Description: \(shortDescription)
    
    Platform: \(platform)
    
    Genre: \(genre)
    
    Developer: \(developer)
    
    Release date: \(releaseDate)
    """
    }
}
