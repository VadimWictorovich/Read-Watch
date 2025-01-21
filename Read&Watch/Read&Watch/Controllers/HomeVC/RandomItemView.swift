//
//  RandomItemView.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 17.01.25.
//

import UIKit
import CoreData


class RandomItemView: UIView {
    
    // MARK: - PROPERTIES
    var delegateCloseView: CloseViewDelegate?
    var items: [AnyObject]?
    private var timerRandomItem: Timer?
    private var randomIndex: Int = 0
    private var stringIndex: Int = 0
    private var timerAnimationString: Timer?
    
    
    // UI properties
    private let labelMain: UILabel = {
        let lab = UILabel()
        lab.font = .boldSystemFont(ofSize: 14)
        //lab.font = .systemFont(ofSize: 14)
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    private let labelSecond: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 14)
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()
    
    private let closeButton: UIButton = {
        let but = UIButton()
        let img = UIImage(systemName: "xmark")
        but.setImage(img, for: .normal)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(nil, action: #selector(closeAction), for: .allTouchEvents)
        //but.isHidden = true
        return but
    }()
    
    private let reapitButton: UIButton = {
        let but = UIButton()
        but.setTitle("Еще раз!", for: .normal)
        but.layer.cornerRadius = 10
        but.layer.borderWidth = 1
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(nil, action: #selector(showTitleItem), for: .allTouchEvents)
        return but
    }()
    
    
    //MARK: - Life circle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        getColor()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - METHODS
    private func setupUI() {
        getColor()
        layer.cornerRadius = 20
        layer.borderWidth = 2.0
        addSubview(labelMain)
        addSubview(labelSecond)
        addSubview(closeButton)
        addSubview(reapitButton)
        setupConstrains()
    }
    
    private func getColor() {
        switch traitCollection.userInterfaceStyle {
        case .unspecified:
            backgroundColor = #colorLiteral(red: 0, green: 0.08763525635, blue: 0.1566192508, alpha: 1)
            layer.borderColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        case .light:
            let col1 = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            reapitButton.setTitleColor(col1, for: .normal)
            reapitButton.layer.borderColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            labelMain.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            closeButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case .dark:
            backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            layer.borderColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            reapitButton.setTitleColor(.white, for: .normal)
            reapitButton.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            labelMain.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            closeButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        @unknown default:
            backgroundColor = #colorLiteral(red: 0, green: 0.08763525635, blue: 0.1566192508, alpha: 1)
            layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        }
    }
    
    
    private func setupConstrains() {
        NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: labelMain, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: labelMain, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: labelMain, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerYWithinMargins, multiplier: 1.0, constant: -20.0).isActive = true
        NSLayoutConstraint(item: labelSecond, attribute: .top, relatedBy: .equal, toItem: labelMain, attribute: .topMargin, multiplier: 1.0, constant: 35.0).isActive = true
        NSLayoutConstraint(item: labelSecond, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: labelSecond, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -30.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 30.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: -20.0).isActive = true
    }
    
    
    @objc private func closeAction() {
        delegateCloseView?.closeView()
    }
    
    // РАБОЧИЙ МЕТОД ПЕРЕБОРА ТЕКСТА
    @objc func showTitleItem() {
        timerRandomItem?.invalidate()
        labelSecond.text = ""
        var elapsedTime: TimeInterval = 0
        let totalDuration: TimeInterval = 3.0 // Общая продолжительность анимации
        let interval: TimeInterval = 0.07 // Интервал изменения текста
        timerRandomItem = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self, let items else { return }
            self.randomIndex = Int.random(in: 0..<items.count)
            var item = items[self.randomIndex]
            self.labelMain.text = getNameOrOther(get: item, is: true)
            elapsedTime += interval
            if elapsedTime >= totalDuration {
                timer.invalidate()
                self.showFinalItem(item: item)
            }
        }
    }
    
    
    private func getNameOrOther(get item: AnyObject,is name: Bool) -> String {
        if name {
            switch item {
            case let book as Book:
                return book.name ?? "ПУСТО"
            case let movie as Movie:
                return movie.name ?? "ПУСТО"
            default:
                return "ОШИБКА"
            }
        } else {
            switch item {
            case let book as Book:
                return "автор: \(book.author ?? "ПУСТО")"
            case let movie as Movie:
                return "жанр: \(movie.genre ?? "ПУСТО")"
            default:
                return "ОШИБКА"
            }
        }
    }
    
    
    private func getFinalTitle(get item: AnyObject) -> String {
        if let item = item as? Book {
            //return "Советую Вам прочитать \n'\(item.name ?? "ПУСТО")' \nавтор: \(item.author ?? "ПУСТО")"
            return "Советую Вам прочитать \n'\(item.name ?? "ПУСТО")'"
        } else if let item = item as? Movie {
            //return "Советую Вам посмотреть \n'\(item.name ?? "EMPTY")' \nжанр: \(item.genre ?? "EMPTY")"
            return "Советую Вам к просмотру \n'\(item.name ?? "EMPTY")'"
        } else { return "Ошибка!!!!!"}
    }
    
    
    private func showFinalItem(item: AnyObject) {
        labelMain.text = getFinalTitle(get: item)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) { [weak self] in
            self?.startTypingAnimation(by: item)
        }
    }
     
    
    // VARIANT 2
    private func startTypingAnimation(by item: AnyObject) {
            timerAnimationString?.invalidate()
            var myString = getNameOrOther(get: item, is: false)
            stringIndex = 0
            timerAnimationString = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] timer in
                guard let self else { return }
                if self.stringIndex < myString.count {
                    let index = myString.index(myString.startIndex, offsetBy: self.stringIndex)
                    self.labelSecond.text?.append(myString[index])
                    self.stringIndex += 1
                } else {
                    timer.invalidate()
                }
            }
        }
}
