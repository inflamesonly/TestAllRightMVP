//
//  Pair.swift
//  TestAllRight
//
//  Created by macOS on 04.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

enum Color : String {
    case red
    case yellow
    case gray
    case green
    
    var description: String {
        return self.rawValue
    }
}

struct Pair {
    
    var value: String
    var image: UIImage
    
    static func == (firstPair: Pair, secondPair: Pair) -> Bool {
        return (firstPair.value == secondPair.value && firstPair.image == secondPair.image)
    }
}
