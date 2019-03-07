//
//  Content.swift
//  TestAllRight
//
//  Created by macOS on 04.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

class Content: NSObject {
    
    var answers: [String] = ["a stomach-ache",
                             "a temperature" ,
                             "a cold" ,
                             "a backache" ,
                             "a toothache" ,
                             "an earache" ,
                             "a cough" ,
                             "a headache"]

    var images: [UIImage] = [#imageLiteral(resourceName: "Image") ,
                             #imageLiteral(resourceName: "Image1") ,
                             #imageLiteral(resourceName: "Image2") ,
                             #imageLiteral(resourceName: "Image3") ,
                             #imageLiteral(resourceName: "Image4") ,
                             #imageLiteral(resourceName: "Image5") ,
                             #imageLiteral(resourceName: "Image6") ,
                             #imageLiteral(resourceName: "Image7")]
    
    lazy var aceptedPairs : [Pair] = {
        [Pair(value: "a stomach-ache", image: #imageLiteral(resourceName: "Image")),
         Pair(value: "a backache", image: #imageLiteral(resourceName: "Image1")),
         Pair(value: "an earache", image: #imageLiteral(resourceName: "Image2")),
         Pair(value: "a toothache", image: #imageLiteral(resourceName: "Image3") ),
         Pair(value: "a headache", image: #imageLiteral(resourceName: "Image4")),
         Pair(value: "a temperature", image: #imageLiteral(resourceName: "Image5")),
         Pair(value: "a cough", image: #imageLiteral(resourceName: "Image6")),
         Pair(value: "a cold", image: #imageLiteral(resourceName: "Image7"))]
    }()
}
