//
//  TabBar.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 31.12.24.
//

import UIKit

final class TabBarCont: UITabBarController {
    
    enum Cases: String, CaseIterable {
        case home = "Главная"
        case all = "Все"
    }
    
    private var cases = Cases.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.navigationItem.title = "READ & WATCH"
    }
}
