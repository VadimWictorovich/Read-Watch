//
//  FirstTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 31.12.24.
//

import UIKit

final class FirstTVC: UITableViewController {
    enum Sections: String, CaseIterable {
        case categories = "Категории"
        case add = "Добавить"
        case whatToDo = "Чем заняться?"
    }
    
    //MARK: - Properties
    private let categories = BooksAndMovies.allCases
    private let sections = Sections.allCases
    private weak var tabBarCont: TabBarControoler?
    

    //MARK: - Life circle TVC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.title = "Книги и фильмы"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - Table view data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 80 : 20
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .categories:
            return "Категории"
        case .add:
            return nil
        case .whatToDo:
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .categories:
            return categories.count
        case .add:
            return 1
        case .whatToDo:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CellsFirstTVC
            else { return UITableViewCell() }
        cell.img?.layer.cornerRadius = 5
        switch sections[indexPath.section] {
        case .categories:
            let category = categories[indexPath.row]
            cell.lbl?.text = category.rawValue
            cell.img?.image = indexPath.row == 0 ? UIImage(systemName: "books.vertical.fill") : UIImage(systemName: "movieclapper.fill")
            cell.img?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            cell.img.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        case .add:
            cell.lbl?.text = "Добавить"
            cell.img?.image = UIImage(systemName: "plus.square.fill.on.square.fill")
            //cell.img?.image = UIImage(systemName: "plus.rectangle.on.rectangle")
            cell.img?.backgroundColor = .systemGreen
            cell.img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .whatToDo:
            cell.lbl?.text = "Чем заняться?"
            cell.img?.image = UIImage(systemName: "questionmark.video.fill")
            cell.img.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.img?.backgroundColor = .systemGray
        }
        return cell
    }
    
    // TODO: доделать переходы
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc1 = tabBarController?.viewControllers?[1] as? SecondVC else { return }
        switch sections[indexPath.section] {
        case .categories:
            //tabBarController?.selectedIndex = 1
            switchToTab1(1, animationOptions: .transitionCurlDown)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                vc1.segmentedControl.selectedSegmentIndex = indexPath.row
                vc1.scrollToSection(section: indexPath.row)
            }
        case .add:
            switchToTab1(1, animationOptions: .transitionFlipFromRight)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                vc1.addItem()
            }
        case .whatToDo:
            presentAlert("Данная функция пока не доступна!)", false)
        }
    }
    
    // MARK: - Methods
    private func setupUI() {
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
}
