//
//  DetailsViewController.swift
//  FreeGamesApp
//
//  Created by Никита Тыщенко on 28.03.2024.
//

import UIKit

class DetailsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var gameImage: UIImageView!
    @IBOutlet var detailInfiLabel: UILabel!
    
    // MARK: - Public properties
    var game: Game!
    
    //MARK: - Private properties
    private let networkManager = NetworkManager.shared
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = game.title
        detailInfiLabel.text = game.description
        fetchImage()
    }
    
    // MARK: - Private Methods
    private func fetchImage() {
        let imageURL = URL(string: game.thumbnail)
        gameImage.kf.setImage(with: imageURL)
    }
}
