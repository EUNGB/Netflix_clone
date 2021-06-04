//
//  SearchViewController.swift
//  netflix_clone
//
//  Created by Weeds on 2021/06/04.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // 키보드 숨김 처리
        dismissKeyboard()
        // 검색어 체크
        guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return}
        
        // 네트워킹을 통한 검색
        SearchAPI.search(searchTerm) { ([Movie]) in
            // 컬렉션 뷰로 표현하기
            
        }
        
    }
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

class SearchAPI {
    static func search(_ term: String, completion: @escaping([Movie]) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?")!
        let mediaQuery = URLQueryItem(name: "media", value: "movie")
        let entityQuery = URLQueryItem(name: "entity", value: "movie")
        let termQuery = URLQueryItem(name: "term", value: term)
        urlComponents.queryItems?.append(mediaQuery)
        urlComponents.queryItems?.append(entityQuery)
        urlComponents.queryItems?.append(termQuery)
        
        let requestURL = urlComponents.url!
        
        
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            let successRange = 200..<300
            
            guard error == nil,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  successRange.contains(statusCode) else {
                completion([])
                return
            }
            
            guard let resultData = data else {
                completion([])
                return
            }
            
            let string = String(data: resultData, encoding: .utf8)
            
            
        }
    }
}

struct Response {
    
}

struct Movie {
    
}
