//
//  Constants.swift
//  AgilizTemplate
//
//  Created by CVN on 30/05/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
  In helper we can create logic,ui,enum, extension helper
 */
struct Constant {
    
    struct Application {
        
        static let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        static let mainObjectContext: NSManagedObjectContext = {
            let mainContext = Application.appDelegate.persistentContainer.viewContext
            mainContext.name = "Main Context"
            return mainContext
        }()
        
        static let persistentStoreCoordinator = {
            return Application.appDelegate.persistentContainer.persistentStoreCoordinator
        }
        
        static let dailyDiaryContext: NSManagedObjectContext = {
            //            let dailyContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            //            dailyContext.name = "Private Context"
            //            dailyContext.parent = Constant.Application.mainObjectContext
            return Application.appDelegate.persistentContainer.viewContext
        }()
        
    }
    
    struct Text {
        static let noProjectRecordsFound = "No Project Found"
        static let noPeopleRecordsFound = "No People Found"
    }
    
    struct Screen {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
    }
    
  
    
    struct Board {
        static let projectTableViewController = UIStoryboard(name: "ProjectTableViewController", bundle: nil)

    }
    
    struct Controller {
        static let calorieDetail = "CalorieinfoViewController"
        static let kResource = "ResourceInvolvedViewController"
        static let kMaterialList = "ProjectMaterialListTVC"
        static let kSitePeople = "TodaySiteVisitorViewController"
        static let kDailySiteVisitor = "DailySiteVisitorViewController"
        static let kVariationList = "TodayVariationListViewController"
        static let kHSEQList = "TodayHSEQListVC"
        static let kSiteImages = "SiteImagesVC"
    }
    
    
    struct Segue {
        static let DailyFormIdentifier = "Dailyformviewcontroller"
       
    }
    
    struct ProjectFormVC {
        static let kAddTitle = "New Project"
        static let kUpdateTitle = "Update Project"
    }
    struct EventVC {
        static let kCantDeleteTitle = "Can't Delete"
        static let kDeleteTaskMessage = "This task has been associate with daily reports"
        static let kDeleteResourceMessage = "This resource has been associate with daily reports"
        static let kDeleteMaterialMessage = "This material has been associate with daily reports"
    }
   
    struct  PeopleForm{
        static let kSearchKey = "lastName"
        static let kFirstName = "peopleFirstName"
        static let kLastName = "peopleLastName"
        static let kPosition = "peoplePosition"
        static let kCategory = "peopleCategory"
        static let kDateOfInduction = "peopleDateOfInduction"
        static let kCompany = "peopleCompany"
        static let kMobileNumber = "peopleMobileNumber"
        static let kCost = "peopleCost"
        //  static let kSectionKey = "lastName"
        
        static let kCategoryTypes = ["Contractor", "Client", "Sub-Contractor", "Supplier", "Other"]
    }
    
    struct PeopleVC {
        static let kTitle = "People"
        static let kCantDeleteMessage = "This person has been associated with daily report"
    }
    
    struct ProjectAddTask {
        static let kTaskName = "taskName"
        static let kDescription = "taskDescription"
        static let kSectionTask = "addTask"
    }
    
    struct ProjectAddResource{
        static let kResourceName = "resourceName"
        static let kResourceCost = "costPerHour"
        static let kSectionResource = "addResource"
    }
    
    struct ProjectAddMaterial {
        static let kMaterialName = "materialName"
        static let kMaterialSupplier = "materialSupplier"
        static let kMaterialQuantity = "materialQuantity"
        static let kPurchaseOrderNumber = "purchaseOrderNumber"
        static let kCostPerUnit = "costPerUnit"
        static let kSectionMaterial = "addMaterial"
    }
    
  
    
    struct TodayTask {
        static let kTitle = "Task Plan"
    }
    
    struct SiteVisitors {
        static let kTitle = "Site Visitors"
    }
    
    struct ResourceInvolved {
        static let kTitle = "Resource Involved"
    }
    
    struct History {
        static let kTitle = "Work History"
    }
    
    struct SiteImageVC {
        static let kTitle = "Gallery"
    }
    
    struct DailyActivityForm {
        static let kcurrentDate = "currentDate"
        static let khowWasTheDay = "howWasTheDay"
        static let kwakeUpTime = "wakeUpTime"
        static let kworkOutTime = "workOutTime"
        static let kleftfromHome = "leftfromHome"
        static let kwentOutsideAfterOffice = "wentOutsideAfterOffice"
        static let kreachedHome = "reachedHome"
        static let kreadAnyBooks = "readAnyBooks"
        static let kexpenses = "expenses"
        static let kwentBed = "wentBed"
        static let kanySpecial = "anySpecial"
        static let kexpenseInfo = "expInfo"
    }
}
