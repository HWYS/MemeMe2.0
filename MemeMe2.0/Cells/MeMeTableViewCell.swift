//
//  MeMeTableViewCell.swift
//  MemeMe2.0
//
//  Created by HtetWaiYanSwe on 11/07/2021.
//

import UIKit

class MeMeTableViewCell: UITableViewCell {

    @IBOutlet weak var meMeText: UILabel!
    @IBOutlet weak var meMeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
