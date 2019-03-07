//
//  AnswerCell.swift
//  TestAllRight
//
//  Created by macOS on 04.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
    func configure (text : String) {
        self.answerLabel.text = text
        self.setMinimumScale()
    }
    
    func setMinimumScale () {
        self.answerLabel.minimumScaleFactor = 10 / UIFont.labelFontSize
        self.answerLabel.adjustsFontSizeToFitWidth = true
    }
}
