//
//  TabBarControoler.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit

class TabBarControoler: UITabBarController, UITabBarControllerDelegate {
    
    
    //life circles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupUIVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // TabBarCont delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            guard let fromView = selectedViewController?.view,
                  let toView = viewController.view,
                  fromView != toView else {
                return true
            }
        
//        if selectedViewController == tabBarController.viewControllers?[2] {
//            presentAlert("Пока нельзя)", false)
//            return false
//        }

            // Добавляем анимацию плавного перехода
            UIView.transition(
                from: fromView,
                to: toView,
                duration: 0.3,
                options: [.transitionCrossDissolve],
                completion: nil
            )

            // Устанавливаем выбранный контроллер вручную
            self.selectedViewController = viewController

            // Возвращаем false, чтобы стандартный механизм не выполнялся
            return false
        }
    
    
    // Methods
    private func setupUIVC() {
        tabBar.tintColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
    }
    
    
}
