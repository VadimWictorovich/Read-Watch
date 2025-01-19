//
//  Extentions.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit
import NVActivityIndicatorView
import NVActivityIndicatorViewExtended


// UIViewCont
extension UIViewController: NVActivityIndicatorViewable {
    
    // Alert
    func presentAlert(_ title: String,_ go: Bool) {
        let alert = UIAlertController(title: "Внимание", message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Понял", style: .cancel, handler: { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if go {
                    self?.switchToTab1(0, animationOptions: .transitionFlipFromRight)
                } else { return }
            }
        }))
        self.present(alert, animated: true)
        //if go { tabBarController?.selectedIndex = 0 } else { return }
    }
    
    
    // переходы
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
    
    
    // Анимация загрузки
    func startActivityAnimation() {
        startAnimating(message: "Загрузка...", type: .ballClipRotate, color: .white, textColor: .white)
    }
    
    func stopActivityAnimation() {
        stopAnimating()
    }
    
    
    // задаем цвет
    func setBackgroudGradientColor(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer})
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func updateBckgroundColor()  {
        switch traitCollection.userInterfaceStyle {
        case .unspecified:
            setBackgroudGradientColor(color1: .white, color2: .red)
        case .light:
            let col1 = #colorLiteral(red: 0.7649147727, green: 0.7649147727, blue: 0.7649147727, alpha: 1)
            setBackgroudGradientColor(color1: .white, color2: col1)
        case .dark:
            let col1 = #colorLiteral(red: 0.1363241793, green: 0.1363241793, blue: 0.1363241793, alpha: 1)
            setBackgroudGradientColor(color1: .black, color2: col1)
        @unknown default:
            setBackgroudGradientColor(color1: .white, color2: .blue)
        }
    }
}
