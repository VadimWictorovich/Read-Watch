//
//  TabBarControoler.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit

class TabBarControoler: UITabBarController {
    
    var someVar: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        print("*** \(#function) количество контроллеров \(children.count) ***")
        print("*** \(#function) количество контроллеров \(viewControllers?.count ?? 0) ***")
        
        /*
         доделать!!!!!!
         let firstVC = UIViewController()
                 firstVC.view.backgroundColor = .red
                 firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)

                 let secondVC = UIViewController()
                 secondVC.view.backgroundColor = .green
                 secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)

                 let thirdVC = UIViewController()
                 thirdVC.view.backgroundColor = .blue
                 thirdVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)

                 viewControllers = [firstVC, secondVC, thirdVC]
         */

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
