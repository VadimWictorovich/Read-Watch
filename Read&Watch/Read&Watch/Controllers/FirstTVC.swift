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

    //MARK: - Life circle TVC

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Книги и фильмы"
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        switch sections[indexPath.section] {
        case .categories:
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.rawValue
        case .add:
            cell.textLabel?.text = "Добавить"
        case .whatToDo:
            cell.textLabel?.text = "Чем заняться?"
        }
        return cell
    }
    
    // TODO: доделать переходы
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        
    }
    
    
}
