//
//  GameCell.swift
//  FreeGamesApp
//
//  Created by Никита Тыщенко on 27.03.2024.
//

import UIKit
import Kingfisher

final class GameCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var gameNameLabel: UILabel!
    
    // MARK: - Public methods
    func configure(with game: Game) {
        gameNameLabel.text = game.title
        
        let imageURL = URL(string: game.thumbnail)
        gameImage.kf.setImage(with: imageURL)
    }
}
