//
//  ViewController.swift
//  FreeGamesApp
//
//  Created by Никита Тыщенко on 27.03.2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    //MARK: - Private properties
    private let networkManager = NetworkManager.shared
    private var gamesFree: [Game] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFreeGames()
    }
    
//    // MARK: - Navigation
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "gameInfo", sender: indexPath)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = sender as? IndexPath else { return }
//        
//        let detailsVC = segue.destination as? DetailsViewController
//        detailsVC?.game = gamesFree[indexPath.item]
//    }

    
    // MARK: - UICollectionViewDataSource
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        gamesFree.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell",for: indexPath)
        guard let cell = cell as? GameCell else { return UICollectionViewCell() }
        let game = gamesFree[indexPath.item]
        cell.configure(with: game)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: (view.window?.windowScene?.screen.bounds.width ?? 100) / 2 - 30,
            height: 120
        )
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchFreeGames() {
        networkManager.fetchFreeGames(from: Link.freeGamesURL.url) { [unowned self] result in
            switch result {
            case .success(let games):
                gamesFree = games
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

