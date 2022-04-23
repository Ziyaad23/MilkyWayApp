//
//  TableViewCell.swift
//  MilkyWay
//
//  Created by user220267 on 4/23/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPhotographDate: UILabel!
    @IBOutlet weak var imgCenter: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
