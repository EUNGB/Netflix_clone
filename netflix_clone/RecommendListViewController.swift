//
//  RecommendListViewController.swift
//  netflix_clone
//
//  Created by Weeds on 2021/06/04.
//

import UIKit

class RecommendListViewController: UIViewController {
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    let viewModel = RecommendListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        sectionTitle.text = viewModel.type.title
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */

extension RecommendListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCell", for: indexPath) as? RecommendCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.item(at: indexPath.row)
        cell.updateUI(movie: movie)
        return cell
    }
    
}

class RecommendListViewModel {
    enum RecommendingType {
        case award
        case hot
        case my
        
        var title: String {
            switch self {
            case .award:
                return "아카데미 호평 영화"
            case .hot:
                return "취향저격 HOT 콘텐츠"
            case .my:
                return "내가 찜한 콘텐츠"
            }
        }
    }
    
    private (set) var type: RecommendingType = .my
    private var items: [DummyItem] = []
    
    var numOfItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> DummyItem {
        return items[index]
    }
    
    func updateType(_ type: RecommendingType) {
        self.type = type
    }
    
    func fetchItems() {
        self.items = MovieFetcher.fetch(type)
    }
}

class RecommendCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    func updateUI(movie: DummyItem) {
        thumbnailImage.image = movie.thumbnail
    }
}

class MovieFetcher {
    static func fetch(_ type: RecommendListViewModel.RecommendingType) -> [DummyItem] {
        switch type {
        case .award:
            let movies = (1..<10).map {DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!)}
            return movies
        case .hot:
            let movies = (10..<19).map {DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!)}
            return movies
        case .my:
            let movies = (1..<10).map {$0 * 2}.map {DummyItem(thumbnail: UIImage(named: "img_movie_\($0)")!)}
            return movies
        }
    }
}

struct DummyItem {
    let thumbnail: UIImage
}
