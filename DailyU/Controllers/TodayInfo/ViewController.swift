//
//  ViewController.swift
//  DailyU
//
//  Created by CVN on 30/05/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class ViewController: FormViewController {
    
    var dailyRecord:DailyInfo?
    var isFromUpdate = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var dailyInfoArray:[DailyInfo]?
    
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self .updateDisplay()
        self .generateDailyInfoForm()
        
    }

    // MARK:- Private methods
    
    private func updateDisplay() {
        self.navigationItem.title = "Add Today info"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveDetails));
        // self.navigationItem.rightBarButtonItem?.isEnabled = (projectRecord != nil) ? true : false
    }
    
    // MARK: - UI Controls
    
    /// We used Eureka Framework to create UI elements
    
    private func generateDailyInfoForm() {
        
        form +++ Section("Today Details")
        
            <<< DateRow(){ row in
                row.title = "Date"
                row.value = dailyRecord?.currentdate
                row.tag = Constant.DailyActivityForm.kcurrentDate
            }
            <<< TimeRow(){ row in
                row.title = "Wakeup Time"
                row.value = dailyRecord?.wakeuptime
                row.tag = Constant.DailyActivityForm.kwakeUpTime
            }
            <<< PushRow<String>(){ row in
                row.title = "WorkoutTime"
                row.value = dailyRecord?.workouttime
                row.options = ["0 min","5 min","15 min","30 min","45 min"]
                row.selectorTitle = "Select Time"
                 row.tag = Constant.DailyActivityForm.kworkOutTime
                }.onPresent({ (from, to) in
                    to.dismissOnSelection = true
                    to.dismissOnChange = false
                })
        
            <<< TimeRow(){ row in
                row.title = "LeftFromHome"
                row.value = dailyRecord?.leftfromhome
                row.tag = Constant.DailyActivityForm.kleftfromHome
//                row.add(rule: RuleRequired(msg: "\(row.title ?? "Field") Required!"))
            }
            
            
            <<< TextAreaRow(){ row in
                row.placeholder = "WentOutsideDetails"
                row.title = "WentOutsideDetails"
                row.value = dailyRecord?.wentoutside
                row.tag = Constant.DailyActivityForm.kwentOutsideAfterOffice
        }
            <<< TimeRow(){ row in
                row.title = "ReachedHome"
                 row.value = dailyRecord?.reachedhome
                row.tag = Constant.DailyActivityForm.kreachedHome
        }
            <<< TextAreaRow(){ row in
                row.placeholder = "ReadBooks"
                row.title = "ReadBooks"
                row.value = dailyRecord?.readanybooks
                row.tag = Constant.DailyActivityForm.kreadAnyBooks
        }
            <<< PhoneRow(){ row in
                row.title = "Expenses"
                row.value = dailyRecord?.expenses
                row.tag = Constant.DailyActivityForm.kexpenses
                row.cell.textField.delegate = self
        }
            <<< TextAreaRow(){ row in
                row.placeholder = "Exp Info"
                row.title = "Exp Info"
                row.value = dailyRecord?.expenseinfo
                row.tag = Constant.DailyActivityForm.kexpenseInfo
            }
            <<< TimeRow(){ row in
                row.title = "BedTime"
                 row.value = dailyRecord?.wentbed
                row.tag = Constant.DailyActivityForm.kwentBed
        }
            <<< TextAreaRow(){ row in
                row.placeholder = "AnyImportant"
                row.title = "AnyImportant"
                 row.value = dailyRecord?.anyspecial
                row.tag = Constant.DailyActivityForm.kanySpecial
        }
            <<< TextAreaRow(){ row in
                row.placeholder = "How Was the day"
                row.title = "How Was the day"
                row.value = dailyRecord?.howwastheday
                row.tag = Constant.DailyActivityForm.khowWasTheDay
                
        }
        
    }
    
    // MARK: - Core data methods
    
    /// Saving User details.
    
    @objc func saveDetails() {
        
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        if form.validate() != [] {
            print("form is invalid")
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            return
        }
       // var todayStatus = self .loadData()
        
        var todayInfos = form.values()
        
        let context = appDelegate.persistentContainer.viewContext
        let dailyinfo = (self.dailyRecord != nil) ? dailyRecord! : DailyInfo(context: context)
      
        dailyinfo.currentdate = todayInfos[Constant.DailyActivityForm.kcurrentDate] as? Date
        dailyinfo.howwastheday = todayInfos[Constant.DailyActivityForm.khowWasTheDay] as? String
        dailyinfo.wakeuptime = todayInfos[Constant.DailyActivityForm.kwakeUpTime] as? Date
        dailyinfo.workouttime = todayInfos[Constant.DailyActivityForm.kworkOutTime] as? String
        dailyinfo.leftfromhome = todayInfos[Constant.DailyActivityForm.kleftfromHome] as? Date
        dailyinfo.wentoutside = todayInfos[Constant.DailyActivityForm.kwentOutsideAfterOffice] as? String
        dailyinfo.reachedhome = todayInfos[Constant.DailyActivityForm.kreachedHome] as? Date
        dailyinfo.readanybooks = todayInfos[Constant.DailyActivityForm.kreadAnyBooks] as? String
        dailyinfo.expenses = todayInfos[Constant.DailyActivityForm.kexpenses] as? String
        dailyinfo.wentbed = todayInfos[Constant.DailyActivityForm.kwentBed] as? Date
        dailyinfo.anyspecial = todayInfos[Constant.DailyActivityForm.kanySpecial] as? String
        dailyinfo.expenseinfo = todayInfos[Constant.DailyActivityForm.kexpenseInfo] as? String
       
        
        do {
            try context.save()
        }
        catch {
            print("failed saving")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData() {
        
        let  context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DailyInfo")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "currentdate", ascending: false)]
        fetchRequest.fetchLimit = 1
        do {
            dailyInfoArray = try context.fetch(fetchRequest) as? [DailyInfo]
            for info in dailyInfoArray! {
                
                if self.dailyRecord != nil  {
                     self.dailyRecord = info
                }
               
            }
        }
        catch let err {
            print(err)
        }
        
        
    }
    
    @IBAction func actionCancel(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: TextField Delegates

extension ViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
}
