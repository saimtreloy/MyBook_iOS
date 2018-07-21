//
//  AllBookTableViewCell.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 19/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import UIKit

class AllBookTableViewCell: UITableViewCell {

    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblBookAuthor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
