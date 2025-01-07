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
    //private weak var tabBarCont: TabBarControoler?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Life cirle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        setingsNavBut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = false
        tabBarController?.navigationItem.title = "Весь контент"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        setupSegmentedControl()
    }
    
    // MARK: - Table view data source and delegate
    func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .books:
            return books.isEmpty ? "Данные о книгах отсутствуют" : "Книги (\(books.count))"
        case .movies:
            return movies.isEmpty ? "Данные о фильмах отсутствуют" : "Фильмы (\(movies.count))"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 30 }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 80 }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .brown
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .books:
            return books.count
        case .movies:
            return movies.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.textColor = .gray
        cell.imageView?.tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        switch sections[indexPath.section] {
        case .books:
            let book = books[indexPath.row]
            // book.fill
            cell.textLabel?.text = book.name
            cell.detailTextLabel?.text = book.author
            cell.imageView?.image = UIImage(systemName: "book")
        case .movies:
            let movie = movies[indexPath.row]
            // movieclapper
            cell.textLabel?.text = movie.name
            cell.detailTextLabel?.text = movie.genre
            cell.imageView?.image = UIImage(systemName: "movieclapper")
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
    
    
    private func saveData() {
        do {
            try context.save()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.reloadData()
            }
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
    
    
    // MARK: - UI Methods
    
    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = false
        searchBar.placeholder = "Поиск..."
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    
    func scrollToSection(section: Int) {
        let indexPath = IndexPath(row: 0, section: section)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let section = sender.selectedSegmentIndex
        scrollToSection(section: section)
    }
    
    
    //MARK: - Alert methods
    @objc func addItem() {
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
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            if let textField1 = alert.textFields?[0], let textField2 = alert.textFields?[1],
               let textName = textField1.text, let textAuthor = textField2.text,
               let self, textName != "", textAuthor != ""
            {
                let newBook = Book(context: self.context)
                newBook.name = textName
                newBook.author = textAuthor
                newBook.read = false
                self.books.append(newBook)
                self.tableView.insertRows(at: [IndexPath(row: self.books.count - 1, section: 0)], with: .automatic)
                self.saveData()
            }
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
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            if let textField1 = alert.textFields?[0], let textField2 = alert.textFields?[1],
               let textName = textField1.text, let textGenre = textField2.text,
               let self, textName != "", textGenre != ""
            {
                let newMovie = Movie(context: self.context)
                newMovie.name = textName
                newMovie.genre = textGenre
                newMovie.watched = false
                self.movies.append(newMovie)
                self.tableView.insertRows(at: [IndexPath(row: self.movies.count - 1, section: 1)], with: .automatic)
                self.saveData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    private func setingsNavBut() {
        tabBarController?.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addItem)
    }
}
