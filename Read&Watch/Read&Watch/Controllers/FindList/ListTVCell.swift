//
//  ListTVCell.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 14.01.25.
//

import UIKit

final class ListTVCell: UITableViewCell {
    
    @IBOutlet weak var imageLbl: UIImageView!
    @IBOutlet weak var nameItemLbl: UILabel!
    @IBOutlet weak var yearItemLbl: UILabel!
    @IBOutlet weak var ganreItemLbl: UILabel!
    @IBOutlet weak var movieLengthItemLbl: UILabel!
    @IBOutlet weak var descrItemLbl: UILabel!
    @IBOutlet weak var kpLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    @IBOutlet weak var tmdbLbl: UILabel!
    @IBOutlet weak var fcLbl: UILabel!
    @IBOutlet weak var rfcLbl: UILabel!
    @IBOutlet weak var awaitLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        imageLbl.layer.cornerRadius = 10
    }

}
