//
//  QuestionCell.swift
//  TestAllRight
//
//  Created by macOS on 04.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet  weak var questionImage: UIImageView!
    
    func configure (image : UIImage) {
        self.questionImage.image = image
    }

}
