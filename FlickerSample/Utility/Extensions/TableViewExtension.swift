//
//  TableViewExtension.swift
//  FlickerSample
//
//  Created by Ravi Tailor on 21/06/18.
//  Copyright © 2018 Ravi Tailor. All rights reserved.
//  Purpose: This tableview extension used to get control over reload data

import Foundation
import UIKit

extension UITableView {
    /**
     * Summary: reloadData:
     * This method gives you full controll after table reload.
     *
     * @param $completion: completion block to execute a piece of code after completion of table reload
     *
     * @return:
     */
    func reloadData(completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion()
            
        }
    }
}
