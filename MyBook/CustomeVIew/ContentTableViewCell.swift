//
//  ContentTableViewCell.swift
//  MyBook
//
//  Created by Navana Real Estate Ltd. on 21/7/18.
//  Copyright © 2018 Nano IT. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var lblContentName: UILabel!
    @IBOutlet weak var lblContentBookName: UILabel!
    @IBOutlet weak var lblContentType: UILabel!
    @IBOutlet weak var lblContentDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
