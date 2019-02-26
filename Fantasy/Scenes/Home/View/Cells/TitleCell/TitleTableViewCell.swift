//
//  TitleTableViewCell.swift
//  Fantasy
//
//  Created by 突突兔 on 2019/2/20.
//  Copyright © 2019 突突兔. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleL: UILabel!
    
}


extension TitleTableViewCell: ClassIdentifiable, NibIdentifiable {}

extension TitleTableViewCell: ConfigurableCell {
    func configure(with object: Any?) {
        guard let model = object as? String else {
            return
        }
        titleL.text = model
    }
}
