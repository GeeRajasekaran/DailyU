//
//  Extensions.swift
//  GRDaily
//
//  Created by CVN on 31/05/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import Foundation
import UIKit
import Eureka

extension FormViewController {
    
    func applyValidation(_ row:BaseRow) {
        let rowIndex = row.indexPath!.row
        while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
            row.section?.remove(at: rowIndex + 1)
        }
        if !row.isValid {
            for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                let labelRow = LabelRow() {
                    $0.title = validationMsg
                    $0.cell.height = { 30 }
                    }.cellUpdate { (cell, _) in
                        cell.textLabel?.textColor = .white
                        cell.backgroundColor = .red
                }
                row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
            }
        }
    }
}
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
