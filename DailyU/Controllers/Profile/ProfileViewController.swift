//
//  ProfileViewController.swift
//  DailyU
//
//  Created by CVN on 03/07/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    var titleInfo = [String]()
    let cellReuseIdentifier = "cell"
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleInfo.append("Convert Currency")
        titleInfo.append("Check Calories")
        titleInfo.append("View Favourite Locations")
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view.
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = titleInfo[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        }
    }
    
}
