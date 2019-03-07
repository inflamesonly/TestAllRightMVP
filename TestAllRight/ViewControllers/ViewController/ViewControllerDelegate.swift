//
//  ViewControllerDelegate.swift
//  TestAllRight
//
//  Created by macOS on 05.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.size.height/CGFloat(self.presenter.content.answers.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.addLine(tableView: tableView, indexPath: indexPath)
    }
}
