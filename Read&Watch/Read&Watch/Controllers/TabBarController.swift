//
//  TabBarController.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 5.01.25.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
            case let vc1 as FirstTVC:
            vc1.navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "First"
            case let vc2 as SecondVC:
            vc2.navigationController?.navigationBar.prefersLargeTitles = false
            navigationItem.title = "Second"

            default:
            break
            }
    }

}
