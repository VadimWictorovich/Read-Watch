//
//  TabBarControoler.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit

class TabBarControoler: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUIVC() {
        tabBar.tintColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
    }
}
