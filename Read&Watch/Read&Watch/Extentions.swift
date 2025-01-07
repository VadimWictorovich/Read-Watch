//
//  Extentions.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit

extension UIViewController {
    func presentAlert(_ title: String) {
        let alert = UIAlertController(title: "Внимание",
                                      message: title,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понял",
                                      style: .cancel))
        self.present(alert, animated: true)
        tabBarController?.selectedIndex = 0
    }
    
    
    
    func presentAddAction() {
        
        
    }
}
