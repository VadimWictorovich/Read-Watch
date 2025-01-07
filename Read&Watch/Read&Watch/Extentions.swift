//
//  Extentions.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit

extension UIViewController {
    
    func presentAlert(_ title: String,_ go: Bool) {
        let alert = UIAlertController(title: "Внимание",
                                      message: title,
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Понял", style: .cancel, handler: { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if go {
                    self?.switchToTab1(0, animationOptions: .transitionFlipFromRight)
                } else {
                    return
                }
            }
        }))
        self.present(alert, animated: true)
        //if go { tabBarController?.selectedIndex = 0 } else { return }
    }
    
    
    func switchToTab1(_ selIndex: Int, animationOptions: UIView.AnimationOptions) {
        guard selIndex >= 0 else { print("Индекс вне диапазона"); return }
        guard let tabCont = tabBarController,
              let viewTab = tabCont.view
        else { print("Нет таббара или вью"); return }

            // Анимация перехода
            UIView.transition(
                with: viewTab,
                duration: 0.3,
                options: animationOptions,
                animations: {
                    tabCont.selectedIndex = selIndex
                },
                completion: nil
            )
        }
}
