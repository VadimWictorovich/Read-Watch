//
//  FindListTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 11.01.25.
//

import UIKit

final class FindListTVC: UITableViewController {
    
    var showMoviesList: [Doc] = []
    var showBooksList: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Результаты поиска"
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { showMoviesList.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        return cell
    }
    
    private func setGenre(_ arr: [Genre]) -> [String] {
        var arrStr: [String] = []
        arr.forEach { item in
            if let str = item.name { arrStr.append(str) }
        }
        return arrStr
    }
    
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
