//
//  LogicHelper.swift
//  GRDaily
//
//  Created by CVN on 05/06/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import Foundation
import UIKit

struct LogicHelper {
    
   static func compareDate(date1:NSDate, date2:NSDate) -> Bool {
        let order = NSCalendar.current.compare(date1 as Date, to: date2 as Date,
                                               toGranularity: .day)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }    
}
