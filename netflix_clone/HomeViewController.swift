//
//  HomeViewController.swift
//  netflix_clone
//
//  Created by Weeds on 2021/06/04.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var awardRecommendListVC: RecommendListViewController!
    var hotRecommendListVC: RecommendListViewController!
    var myRecommendListVC: RecommendListViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.bounces = false
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "award" {
            let destinationVC = segue.destination as? RecommendListViewController
            awardRecommendListVC = destinationVC
            awardRecommendListVC.viewModel.updateType(.award)
            awardRecommendListVC.viewModel.fetchItems()
        } else if segue.identifier == "hot" {
            let destinationVC = segue.destination as? RecommendListViewController
            hotRecommendListVC = destinationVC
            hotRecommendListVC.viewModel.updateType(.hot)
            hotRecommendListVC.viewModel.fetchItems()
        } else if segue.identifier == "my" {
            let destinationVC = segue.destination as? RecommendListViewController
            myRecommendListVC = destinationVC
            myRecommendListVC.viewModel.updateType(.my)
            myRecommendListVC.viewModel.fetchItems()
        }
    }
    

}
