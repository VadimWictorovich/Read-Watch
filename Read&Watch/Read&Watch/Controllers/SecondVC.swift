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
    var books: [Book] = []
    var movies: [Movie] = []
    var incompleteBooks: [Book] { return books.filter { !$0.read } }
    var incompleteMovies: [Movie] { return movies.filter { !$0.watched } }
    private var searchData: [AnyObject] = []
    private var isSearching: Bool { return !(searchBar.text?.isEmpty ?? true) }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Life cirle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        setingsNavBut()
        setupSearch()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = false
        tabBarController?.navigationItem.title = "Весь контент"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        setupSegmentedControl()
    }
  
    
    // MARK: - Table view data source and delegate
    func numberOfSections(in tableView: UITableView) -> Int { return isSearching ? 1 : sections.count }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section] {
        case .books:
            if isSearching { return "Результаты поиска"}
            return incompleteBooks.isEmpty ? "Данные о книгах отсутствуют" : "Книги (\(incompleteBooks.count))"
        case .movies:
            return incompleteMovies.isEmpty ? "Данные о фильмах отсутствуют" : "Фильмы (\(incompleteMovies.count))"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 30 }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 50 }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .brown
        header.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchData.count
        } else {
            switch sections[section] {
            case .books:
                return incompleteBooks.count
            case .movies:
                return incompleteMovies.count
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.detailTextLabel?.textColor = .gray
        if !isSearching {
            cell.imageView?.tintColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            switch sections[indexPath.section] {
            case .books:
                let book = incompleteBooks[indexPath.row]
                cell.textLabel?.text = book.name
                cell.detailTextLabel?.text = book.author
                cell.imageView?.image = UIImage(systemName: "book")
            case .movies:
                let movie = incompleteMovies[indexPath.row]
                cell.textLabel?.text = movie.name
                cell.detailTextLabel?.text = movie.genre
                cell.imageView?.image = UIImage(systemName: "movieclapper")
            }
        } else {
            let item = searchData[indexPath.row]
            if let book = item as? Book {
                cell.textLabel?.text = book.name
                cell.detailTextLabel?.text = book.author
                cell.imageView?.image = UIImage(systemName: "book")
            } else if let movie = item as? Movie {
                cell.textLabel?.text = movie.name
                cell.detailTextLabel?.text = movie.genre
                cell.imageView?.image = UIImage(systemName: "movieclapper")
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "FindListTVC") as? FindListTVC else { return }
        switch sections[indexPath.section] {
        case .books:
            presentAlert("Контент не найден", false)
        case .movies:
            startActivityAnimation()
            guard let movieName = incompleteMovies[indexPath.row].name else { return }
            NetworkService.searchMoviesByName(movieName: movieName) { [weak self] result, error in
                guard let result else { print (" ***** \(#function) нет объекта"); return }
                let arr =  result.docs
                DispatchQueue.main.async {
                    if arr.isEmpty {
                        self?.stopActivityAnimation()
                        self?.presentAlert("Контент не найден", false)
                    } else {
                        vc.showMoviesList = arr
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { return isSearching ? false : true }
    
    //удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch sections[indexPath.section] {
            case .books:
                let bookToDelete = incompleteBooks[indexPath.row]
                deleteItem(bookToDelete, from: &books, row: indexPath.row, in: 0)
            case .movies:
                let movieToDelete = incompleteMovies[indexPath.row]
                deleteItem(movieToDelete, from: &movies, row: indexPath.row, in: 1)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let indSect = indexPath.section
        let completeAction = UIContextualAction(style: .normal, title: setTitleSwipeAction(indSect)) { [weak self] _, _, _ in
            guard let self else { return }
            switch sections[indexPath.section] {
            case .books:
                let goBook = self.incompleteBooks[indexPath.row]
                markCompleteItem(goBook, witchKey: \.read, get: \.completeDate, from: &books, row: indexPath.row, in: 0)
            case .movies:
                let goMovie = self.incompleteMovies[indexPath.row]
                markCompleteItem(goMovie, witchKey: \.watched, get: \.completeDate, from: &movies, row: indexPath.row, in: 1)
            }
        }
        completeAction.backgroundColor = #colorLiteral(red: 0, green: 0.5907812036, blue: 0.5686688286, alpha: 1)
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        return configuration
    }
    
    
    private func setTitleSwipeAction (_ section: Int) -> String {
            switch section {
            case 0: return "Прочитано"
            case 1: return "Просмотрено"
            default: return "Ошибка" }
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.tableView.reloadData()
            }
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    // удалить
    private func saveForAsyncMethods() {
        do {
            try context.save()
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
        tableView.separatorStyle = .none
        searchBar.delegate = self
        navigationController?.navigationBar.tintColor = .gray
    }
    
    
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    
    private func setingsNavBut() {
        tabBarController?.navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addItem)
    }
    
    
    func scrollToSection(section: Int) {
        if section == 0 && incompleteBooks.isEmpty { return }
        if section == 1 && incompleteMovies.isEmpty { return }
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
    
    
    //MARK: - Методы по добавлению экземпляров книг и фильмов
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
               let self, textName != "", textAuthor != "" {
                    let newBook = Book(context: self.context)
                    newBook.name = textName
                    newBook.author = textAuthor
                    newBook.read = false
                    newBook.id = UUID()
                    self.books.append(newBook)
                    self.tableView.insertRows(at: [IndexPath(row: self.incompleteBooks.count - 1, section: 0)], with: .automatic)
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
                newMovie.id = UUID()
                self.movies.append(newMovie)
                self.tableView.insertRows(at: [IndexPath(row: self.incompleteMovies.count - 1, section: 1)], with: .automatic)
                self.saveData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - Методы по удалению экземпляров книг и фильмов
    private func deleteItem<T: NSManagedObject>(_ item: T, from array: inout [T],row indexPath: Int,  in section: Int) {
        guard let index = array.firstIndex(where: { $0 == item} ) else { print ("Нет объекта для удаления"); return }
        let deleteItem = array[index]
        context.delete(deleteItem)
        saveForAsyncMethods()
        array.remove(at: index)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.deleteRows(at: [IndexPath(row: indexPath, section: section)], with: .fade)
            self?.tableView.reloadData()
        }
    }

    
    //MARK: - Методы по переносу экземпляров книг и фильмов на третий экран
    private func markCompleteItem<T: NSManagedObject>(_ item: T, witchKey keyPath: ReferenceWritableKeyPath<T, Bool>,get dateStr: ReferenceWritableKeyPath<T, String?>, from array: inout [T], row indexPath: Int, in section: Int) {
        guard let index = array.firstIndex(where: { $0 == item} ) else { print ("Нет объекта для переносаа в категорию ВЫПОЛНЕНО"); return }
            let strDate = setupActualDate()
            array[index][keyPath: keyPath] = true
            array[index][keyPath: dateStr] = strDate
            saveForAsyncMethods()
            DispatchQueue.main.async { [weak self] in
                self?.tableView.deleteRows(at: [IndexPath(row: indexPath, section: section)], with: .fade)
                self?.tableView.reloadData()
            }
    }
    
    
    private func setupActualDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: currentDate)
        return dateString
    }
    
    
    // MARK: - SearchBar Delegate and methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData(for: searchText)
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchData.removeAll()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    private func setupSearch() {
        searchBar.placeholder = "Поиск"
        searchBar.searchBarStyle = .minimal
    }
    
    
    private func filterData(for searchText: String) {
        searchData.removeAll()
        if !searchText.isEmpty {
            searchData = books.filter { $0.name?.localizedCaseInsensitiveContains(searchText) == true } +
                         movies.filter { $0.name?.localizedCaseInsensitiveContains(searchText) == true }
        }
    }
}
