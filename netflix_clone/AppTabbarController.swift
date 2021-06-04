//
//  AppTabbarController.swift
//  netflix_clone
//
//  Created by Weeds on 2021/06/04.
//

import UIKit

class AppTabbarController: UITabBarController {

    override var shouldAutorotate: Bool {
         return false
     }
     
     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
         return .portrait
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

