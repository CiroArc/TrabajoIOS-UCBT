//
//  MiTableCell.swift
//  TourWishlist
//
//  Created by USUARIO on 11/14/15.
//  Copyright © 2015 ciroSoft. All rights reserved.
//

import UIKit

class MiTableCell: UITableViewCell {
    
    @IBOutlet weak var LNombre: UILabel!
    @IBOutlet weak var LDescripcion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

