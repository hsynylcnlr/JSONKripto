//
//  KriptoTableViewCell.swift
//  Kripto
//
//  Created by Hüseyin Yalçınlar on 1.02.2021.
//  Copyright © 2021 Hüseyin Yalçınlar. All rights reserved.
//

import UIKit

class KriptoTableViewCell: UITableViewCell {

    @IBOutlet weak var priceText: UILabel!
    @IBOutlet weak var currencyText: UILabel!
    @IBOutlet weak var btnFavori: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func favoriButton(_ sender: Any) {
        print("datcom")
        
    }
}
