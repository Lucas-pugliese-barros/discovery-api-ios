//
//  ApiViewCell.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ApiViewCell: UITableViewCell {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var favoritar: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }    
}
