//
//  TableViewExt.swift
//  TestAllRight
//
//  Created by macOS on 05.03.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func deselectSelectedRow(animated: Bool) {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}

extension UITableView {
    func deselectAllRows(animated: Bool) {
        guard let selectedRows = indexPathsForSelectedRows else { return }
        for indexPath in selectedRows {
            deselectRow(at: indexPath, animated: animated)
        }
    }
}
