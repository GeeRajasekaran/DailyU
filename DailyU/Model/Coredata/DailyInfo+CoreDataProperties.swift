//
//  DailyInfo+CoreDataProperties.swift
//  
//
//  Created by CVN on 13/06/19.
//
//

import Foundation
import CoreData


extension DailyInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyInfo> {
        return NSFetchRequest<DailyInfo>(entityName: "DailyInfo")
    }

    @NSManaged public var anyspecial: String?
    @NSManaged public var currentdate: NSDate?
    @NSManaged public var diaryInfo: String?
    @NSManaged public var expenseinfo: String?
    @NSManaged public var expenses: String?
    @NSManaged public var howwastheday: String?
    @NSManaged public var leftfromhome: NSDate?
    @NSManaged public var mytest: NSDate?
    @NSManaged public var notes: String?
    @NSManaged public var reachedhome: NSDate?
    @NSManaged public var readanybooks: String?
    @NSManaged public var wakeuptime: NSDate?
    @NSManaged public var wentbed: NSDate?
    @NSManaged public var wentoutside: String?
    @NSManaged public var workouttime: String?

}
