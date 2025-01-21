//
//  FindListTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 11.01.25.
//

import UIKit

final class FindListTVC: UITableViewController {
    
    
    var showMoviesList: [Doc] = []
    var showBooksList: [Item] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBckgroundColor()
        navigationItem.title = "Результаты поиска"
        navigationController?.navigationBar.tintColor = .gray
        tableView.separatorStyle = .none

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateBckgroundColor()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { showMoviesList.count }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTVCell else { return UITableViewCell()}
        let item = showMoviesList[indexPath.row]
        cell.nameItemLbl.text = item.name
        cell.yearItemLbl.text = "Год выпуска: \(item.year ?? 0)"
        if let arrGem = item.genres {
            let arrayStr = setGenre(arrGem)
            cell.ganreItemLbl.text = "Жанры: \(arrayStr.joined(separator: ", "))"
        }
        cell.movieLengthItemLbl.text = "Длительность: \(item.movieLength ?? 0) минут"
        cell.descrItemLbl.text = "Краткое описание: \n\(item.shortDescription ?? "Пусто")"
        cell.kpLbl.text = "   KP: \(String(format: "%.1f", item.rating?.kp ?? 0.0))"
        cell.imdbLbl.text = "   IMDB: \(item.rating?.imdb ?? 0.0)"
        cell.tmdbLbl.text = "    TMDB: \(item.rating?.tmdb ?? 0.0)"
        cell.fcLbl.text = "   FC: \(item.rating?.filmCritics ?? 0.0)"
        cell.rfcLbl.text = "   RusFC: \(String(format: "%.1f", item.rating?.russianFilmCritics ?? 0.0))"
        cell.awaitLbl.text = "   Await: \(item.rating?.await ?? 0.0)"
        cell.imageLbl.contentMode = .scaleAspectFill
        if let urlImg = item.poster?.previewUrl, let url = URL(string: urlImg) {
            print ("в \(#function) получен urlImage")
            NetworkService.getMovieImage(imageURL: url) { result, error in
                if let result {
                    DispatchQueue.main.async { [weak self] in
                        cell.imageLbl?.image = result
                        self?.stopActivityAnimation()
                    }
                }
            }
        }
        return cell
         */
        if !showMoviesList.isEmpty {
            let res = showMovis(indexPath: indexPath)
            return res
        } else if !showBooksList.isEmpty {
            let res = showBooks(indexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    private func showMovis(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTVCell else { return UITableViewCell()}
        let item = showMoviesList[indexPath.row]
        cell.nameItemLbl.text = item.name
        cell.yearItemLbl.text = "Год выпуска: \(item.year ?? 0)"
        if let arrGem = item.genres {
            let arrayStr = setGenre(arrGem)
            cell.ganreItemLbl.text = "Жанры: \(arrayStr.joined(separator: ", "))"
        }
        cell.movieLengthItemLbl.text = "Длительность: \(item.movieLength ?? 0) минут"
        cell.descrItemLbl.text = "Краткое описание: \n\(item.shortDescription ?? "Пусто")"
        cell.kpLbl.text = "   KP: \(String(format: "%.1f", item.rating?.kp ?? 0.0))"
        cell.imdbLbl.text = "   IMDB: \(item.rating?.imdb ?? 0.0)"
        cell.tmdbLbl.text = "    TMDB: \(item.rating?.tmdb ?? 0.0)"
        cell.fcLbl.text = "   FC: \(item.rating?.filmCritics ?? 0.0)"
        cell.rfcLbl.text = "   RusFC: \(String(format: "%.1f", item.rating?.russianFilmCritics ?? 0.0))"
        cell.awaitLbl.text = "   Await: \(item.rating?.await ?? 0.0)"
        cell.imageLbl.contentMode = .scaleAspectFill
        if let urlImg = item.poster?.previewUrl, let url = URL(string: urlImg) {
            print ("в \(#function) получен urlImage")
            NetworkService.getMovieImage(imageURL: url) { result, error in
                if let result {
                    DispatchQueue.main.async { [weak self] in
                        cell.imageLbl?.image = result
                        self?.stopActivityAnimation()
                    }
                }
            }
        }
        return cell
    }
    
    
    private func showBooks(indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListTVCell else { return UITableViewCell()}
        let item = showBooksList[indexPath.row].volumeInfo
        cell.nameItemLbl.text = item.title
        cell.descrItemLbl.text = item.description
        return cell
    }
    
    
    private func setGenre(_ arr: [Genre]) -> [String] {
        var arrStr: [String] = []
        arr.forEach { item in
            if let str = item.name { arrStr.append(str) }
        }
        return arrStr
    }
}
