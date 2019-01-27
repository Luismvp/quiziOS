//
//  QuizzesTableViewCell.swift
//  P5_QuizAppIOS2018
//
//  Created by Luis Martin de Vidales Palomero on 19/11/2018.
//  Copyright © 2018 UPM. All rights reserved.
//

import UIKit

class QuizzesTableViewCell: UITableViewCell {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var quiz: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var id: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
