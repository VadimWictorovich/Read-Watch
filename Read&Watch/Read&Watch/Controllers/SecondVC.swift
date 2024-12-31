//
//  SecondVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 31.12.24.
//

import UIKit

class SecondVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let sections = BooksAndMovies.allCases
    private var books = [String]()
    private var movies = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Table view data source and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { sections[section].rawValue }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 30 }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 80 }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .systemYellow
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .books:
            //return books.count
            return 20
        case .movies:
            //return movies.count
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.textColor = .gray
        switch sections[indexPath.section] {
        case .books:
            //            let book = books[indexPath.row]
            //            cell.textLabel?.text = book.name
            //            cell.detailTextLabel?.text = book.des
            cell.textLabel?.text = "Название книги"
            cell.detailTextLabel?.text = "Автор"
            // жанр
        case .movies:
            //            let movie = movies[indexPath.row]
            //            cell.textLabel?.text = movie.name
            cell.textLabel?.text = "Название фильма"
            cell.detailTextLabel?.text = "Жанр"
        }
        return cell
    }
    
    private func setupUI() {
        
    }
    
}