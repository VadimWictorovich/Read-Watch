//
//  RandomItemView.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 17.01.25.
//

import UIKit

class RandomItemView: UIView {
    
    
    // MARK: - PROPERTIES
    var items: [AnyObject] = []
    
    // UI properties
    private let label: UILabel = {
        let lab = UILabel()
        lab.font = .systemFont(ofSize: 10)
        lab.textColor = .white
        lab.textAlignment = .center
        lab.numberOfLines = 0
        lab.translatesAutoresizingMaskIntoConstraints = false
        return lab
    }()

    private let closeButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        but.contentMode = .scaleAspectFill
        but.setTitleColor(.white, for: .normal)
        //but.addTarget(nil, action: #selector(HomeTVController.closeRandomMovieView), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    private let reapitButton: UIButton = {
        let but = UIButton()
        but.setTitle("Неподходит!", for: .normal)
        but.setTitleColor(.white, for: .normal)
        but.layer.cornerRadius = 10
        but.layer.borderWidth = 1.0
        but.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        but.translatesAutoresizingMaskIntoConstraints = false
        //but.addTarget(nil, action: #selector(HomeTVController.showRandomMovie), for: .touchUpInside)
        return but
    }()

    
    //MARK: - Life circle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - METHODS
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0, green: 0.08763525635, blue: 0.1566192508, alpha: 1)
        layer.cornerRadius = 15
        layer.borderWidth = 5.0
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = showTitleItem()
        addSubview(label)
        addSubview(closeButton)
        addSubview(reapitButton)
        setupConstrains()
    }
    
    private func setupConstrains() {
        NSLayoutConstraint(item: closeButton, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: closeButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1.0, constant: 15.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -6.0).isActive = true
        NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 6.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .top, relatedBy: .equal, toItem: label, attribute: .topMargin, multiplier: 1.0, constant: 20.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -30.0).isActive = true
        NSLayoutConstraint(item: reapitButton, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leadingMargin, multiplier: 1.0, constant: 30.0).isActive = true
    }
    
    private func showTitleItem() -> String {
        let item = items.randomElement()
        if let it = item as? Book { return "Советую Вам \nпрочитать \(it.name ?? "ПУСТО") \nавтора - \(it.author ?? "ПУСТО")" } else if let it = item as? Movie { return "Советую Вам \nпосмотреть фильм \(it.name ?? "ПУСТО") \nжанр - \(it.genre ?? "ПУСТО")" } else {
            return "ПУСТО"
        }
    }
    
//    private func randomGetItem() -> AnyObject {
//        
//    }


// func updateUIWithMovie() {
//     guard let movie else {
//        print("Ошибка в методе updateUIWithMovie: объект фильма не инициализирован")
//        return
//     }
//     print("Обновление UI с информацией о фильме: \(movie.name ?? "No value")")
//     DispatchQueue.main.async { [weak self] in
//        self?.nameMovieLabel.text = "\(movie.name ?? "No value"). '\(movie.year?.description ?? " ")'"
//        guard let imageUrlString = movie.poster?.previewUrl,
//              let imageURL = URL(string: imageUrlString) else { return }
//        NetworkService.fetchMovieImage(imageURL: imageURL) { result, error in
//        if let error {
//            print("возникла ошибка в методе updateUIWithMovie при получении изображения: \(error)")
//            return
//        }
//            guard let result else { return }
//            DispatchQueue.main.async { [weak self] in
//                self?.picture.image = result
//
//            }
//        }
//    }
//}
    
    
//@objc func openDetailVC() {
//    guard let movie else { return }
//    delegateClosed?.closedView()
//    delegate?.openVCMovieDetail(at: nil, detail: movie, movieId: nil)
//}

}
