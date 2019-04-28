//
//  FavoriteApiViewCell.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 28/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class FavoriteApiViewCell: UITableViewCell {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
