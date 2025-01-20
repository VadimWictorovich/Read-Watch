//
//  FirstTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 31.12.24.
//

import UIKit
import CoreData

final class FirstTVC: UITableViewController, CloseViewDelegate {
    
    // MARK: - ENUMS
    enum Sections: String, CaseIterable {
        case categories = "Категории"
        case add = "Добавить"
        case whatToDo = "Чем заняться?"
    }
    
    //MARK: - Properties
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let categories = BooksAndMovies.allCases
    private let sections = Sections.allCases
    private weak var tabBarCont: TabBarControoler?
    private lazy var randomItemView = RandomItemView()
    private var bookItems: [Book] = []
    private var movieItems: [Movie] = []
    private var items: [AnyObject] = []
    var blurEff = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    

    //MARK: - Life circle TVC
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBckgroundColor()
        tabBarController?.navigationItem.rightBarButtonItem?.isHidden = true
        tabBarController?.navigationItem.title = "Книги и фильмы"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateBckgroundColor()
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
        cell.selectionStyle = .none
        return cell
    }
    
    
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
            getData()
            items.isEmpty ? presentAlert("Данных нет, добавьте интересуемый контент!", false) : setupRandomView()
        }
    }
    
    // MARK: - Methods
    private func setupUI() {
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
    }
    
    
    private func showRandomView() {
        guard !items.isEmpty else {print("** items is Empty"); return }
        setupRandomView()
        randomItemView.items = items
        randomItemView.showTitleItem()
    }
    
    
    private func setupRandomView() {
         showBlEff()
         randomItemView.frame.size = CGSize(width: 340, height: 230)
         randomItemView.center.x = view.center.x
         randomItemView.center.y = view.center.y - 200
         randomItemView.transform = CGAffineTransform(scaleX: 0.8, y: 1.5)
         randomItemView.delegateCloseView = self
         view.addSubview(randomItemView)
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0) { [weak self] in
             self?.randomItemView.transform = .identity
         }
     }
    
    
    private func showBlEff() {
        blurEff.frame = view.bounds
        view.addSubview(blurEff)
    }
    
    
    private func cancelBlurEffect() {
        blurEff.removeFromSuperview()
    }
    
    
    // MARK: - CoreData methods
    private func loadBooks(with request: NSFetchRequest<Book> = Book.fetchRequest()) {
        do {
            bookItems = try context.fetch(request)
            bookItems.forEach { book in
                if !book.read { items.append(book) }
            }
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    
    private func loadMovies(with request: NSFetchRequest<Movie> = Movie.fetchRequest()) {
        do {
            movieItems = try context.fetch(request)
            movieItems.forEach { movie in
                if !movie.watched { items.append(movie) }
            }
        } catch {
            let error = error as NSError
            fatalError("-- ошибка метода \(#function) класса SecondVC: \(error)")
        }
    }
    
    
    private func getData() {
        loadBooks()
        loadMovies()
    }
    
    
    // MARK: - Relize PROTOCOLS
    func closeView() {
        randomItemView.removeFromSuperview()
        cancelBlurEffect()
    }
}
