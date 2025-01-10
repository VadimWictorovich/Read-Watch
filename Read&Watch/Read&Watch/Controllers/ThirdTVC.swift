//
//  TherdTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 6.01.25.
//

import UIKit
import CoreData

final class ThirdTVC: UITableViewController {

    // MARK: - Properties
//    private let sections = BooksAndMovies.allCases
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var books: [Book] = []
    private var movies: [Movie] = []
    private var booksComplete: [Book] { return books.filter { $0.read } }
    private var movieComplete: [Movie] { return movies.filter { $0.watched } }
    private var allCompleteContent: [Any] { return booksComplete + movieComplete }
    
    
    //MARK: - life circle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.title = "Выполнено"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
        getData()
    }
    

    // MARK: - Table view data source
    // Sections
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
        
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 80 }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return allCompleteContent.isEmpty ? "Нет данных" : "Прочитано: \(booksComplete.count) книг \nи Просмотрено: \(movieComplete.count) фильмов"
    }
    

    // Cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { allCompleteContent.count }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 70 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = allCompleteContent[indexPath.row]
        if let val = item as? Book {
            cell.textLabel?.text = "\(val.name ?? "") \n\(val.author ?? "")"
            cell.imageView?.image = UIImage(systemName: "book")
        } else if let val = item as? Movie {
            cell.textLabel?.text = "\(val.name ?? "") \n\(val.genre ?? "")"
            cell.imageView?.image = UIImage(systemName: "movieclapper")
        }
        cell.imageView?.tintColor = #colorLiteral(red: 0, green: 0.5907812036, blue: 0.5686688286, alpha: 1)
        cell.detailTextLabel?.text = setupDate()
        return cell
    }
    
    
    // Data methods
    private func getData() {
        loadBooks()
        loadMovies()
        tableView.reloadData()
    }
    

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

    // add Date methods
    private func setupDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let dateString = formatter.string(from: currentDate)
        return dateString
    }
}
