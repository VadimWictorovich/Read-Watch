//
//  CellsFirstTVC.swift
//  Read&Watch
//
//  Created by Вадим Игнатенко on 5.01.25.
//

import UIKit

class CellsFirstTVC: UITableViewCell {
    
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
