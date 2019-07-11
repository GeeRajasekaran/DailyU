//
//  HomeViewController.swift
//  GRDaily
//
//  Created by CVN on 04/06/19.
//  Copyright © 2019 Agiliztech. All rights reserved.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var collectionView:UICollectionView!
    
    // MARK: - Properties
    
    let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .touchIdAction()
        self .initialSetup()
        // Do any additional setup after loading the view.
    }
    
   // MARK: - Functions
    
    func initialSetup()  {
        
        self.collectionView.register(UINib(nibName: "TodosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

    }
    
    func navigateToAR()  {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Today", bundle: nil)
        let calViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.calorieDetail) as! CalorieinfoViewController
        self.navigationController?.pushViewController(calViewController, animated: true)
    }

    func touchIdAction() {
        
        print("hello there!.. You have clicked the touch ID")
        
        let myContext = LAContext()
        let myLocalizedReasonString = "Biometric Authntication testing !! "
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            //                            self.successLabel.text = "Awesome!!... User authenticated successfully"
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            //                            self.successLabel.text = "Sorry!!... User did not authenticate successfully"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                //                successLabel.text = "Sorry!!.. Could not evaluate policy."
            }
        } else {
            // Fallback on earlier versions
            
            //            successLabel.text = "Ooops!!.. This feature is not supported."
        }
        
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:TodosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TodosCollectionViewCell
        
        cell.myView.backgroundColor = UIColor.random
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        self .navigateToAR()
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: 300, height: 100)
        }
        return CGSize(width: 300, height: 300)
    }
}
