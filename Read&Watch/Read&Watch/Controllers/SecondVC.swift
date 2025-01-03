//
//  SecondVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 31.12.24.
//

import UIKit
import CoreData

final class SecondVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    // MARK: - Properties
    
    private let sections = BooksAndMovies.allCases
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let addButton: UIBarButtonItem = {
        let but = UIBarButtonItem()
        but.image = UIImage(systemName: "plus")
        return but
    }()
    private var books: [Book] = []
    private var movies: [Movie] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Life cirle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Весь контент"
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
    
    //MARK: - CoreData
    
    private func loadBooks(with request: NSFetchRequest<Book> = Book.fetchRequest()) {
        do {
            books = try context.fetch(request)
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    private func loadMovies(with request: NSFetchRequest<Movie> = Movie.fetchRequest()) {
        do {
            movies = try context.fetch(request)
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    private func getData() {
        loadBooks()
        loadMovies()
        tableView.reloadData()
    }
    
    private func saveData() {
        do {
            try context.save()
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    // MARK: - UI Methods
    
    private func setupUI() {
        tabBarController?.navigationItem.title = "Весь контент"
        searchBar.placeholder = "Поиск..."
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tabBarController?.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addItem)
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    private func scrollToSection(section: Int) {
        let indexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let section = sender.selectedSegmentIndex
        scrollToSection(section: section)
    }
    
    //MARK: Alert methods
    
    @objc private func addItem() {
        let alert = UIAlertController(title: "ДОБАВИТЬ",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Книгу", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.addBook()
        }))
        alert.addAction(UIAlertAction(title: "Фильм", style: .default, handler: { [weak self] _ in
            guard let self else { return }
            self.addMovie()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func addBook() {
        let alert = UIAlertController(title: "Добавить книгу",
                                      message: "Введите необходимые данные о книге",
                                      preferredStyle: .alert)
        alert.addTextField { tf1 in
            tf1.placeholder = "Название"
        }
        alert.addTextField { tf2 in
            tf2.placeholder = "Автор"
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    private func addMovie() {
        let alert = UIAlertController(title: "Добавить фильм",
                                      message: "Введите необходимые данные о фильме",
                                      preferredStyle: .alert)
        alert.addTextField { tf1 in
            tf1.placeholder = "Название"
        }
        alert.addTextField { tf2 in
            tf2.placeholder = "Жанр"
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { _ in
            
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
}
