//
//  HistoryTableViewController.swift
//  GRDaily
//
//  Created by CVN on 01/06/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    fileprivate let kReuseIdentifier = "myCell"
    var appDelegate = UIApplication.shared.delegate as? AppDelegate

        
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<DailyInfo> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<DailyInfo> = DailyInfo.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "currentdate", ascending: false)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: (appDelegate?.persistentContainer.viewContext)!, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self .initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView .reloadData()
    }
    
    // MARK:- Private Methods
    
    private func initialSetup() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.actionCreateDailyInfo))
        self.title = "History"
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("Unable to Perform Fetch Request")
            print("\(fetchError), \(fetchError.localizedDescription)")
        }

    }
    @objc func actionCreateDailyInfo() {
        // Do  new model page navigation here
        guard let sections = fetchedResultsController.sections else {
            self.performSegue(withIdentifier: Constant.Segue.DailyFormIdentifier, sender: nil)
            return
        }
        let sectionInfo = sections[0]
        if sectionInfo.numberOfObjects > 0 {
            let currentRecord:DailyInfo = fetchedResultsController.object(at: IndexPath(row: 0, section: 0))
            if LogicHelper.compareDate(date1: currentRecord.currentdate as! NSDate , date2: Date() as NSDate) {
                self.performSegue(withIdentifier: Constant.Segue.DailyFormIdentifier, sender: currentRecord)
            }
            else {
                self.performSegue(withIdentifier: Constant.Segue.DailyFormIdentifier, sender: nil)
                
            }
        }
        else {
            self.performSegue(withIdentifier: Constant.Segue.DailyFormIdentifier, sender: nil)
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let sections = fetchedResultsController.sections else {
            return 0
        }
        
        /*get number of rows count for each section*/
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: kReuseIdentifier, for: indexPath) as! DailyInfoTableViewCell
        
        let dailyRecord = fetchedResultsController.object(at: indexPath)
//        cell.delegate = self
        cell.updateDailyInfoCellDisplay(with: dailyRecord)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRecord = fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: Constant.Segue.DailyFormIdentifier, sender: currentRecord)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let projectNavController = segue.destination as! UINavigationController
    
            let dailyform = projectNavController.visibleViewController as! ViewController
            if let currentRecord = sender as? DailyInfo {
                dailyform.dailyRecord = currentRecord
            }
        
    }
}
extension HistoryTableViewController:NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = newIndexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        case .move:
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        updateResult()
    }
    
   
    private func updateResult() {
        let count = self.fetchedResultsController.fetchedObjects?.count ?? 0
//        self.noResultLabel.isHidden = count > 0 ? true : false
        self.tableView.isScrollEnabled = count > 0 ? true : false
    }
    
    
}
