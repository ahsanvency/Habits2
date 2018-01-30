//
//  MainScreenViewC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/4/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class MainScreenViewC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var success: Int?
    var intrinsicQuestions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        func reloadDataAfterDelay(delayTime: TimeInterval = 3) -> Void {
//            self.perform(#selector(self.tableView.reloadData), with: nil, afterDelay: delayTime)
//        }
        guard let user = Auth.auth().currentUser else {
        return
    }
        let uid = user.uid
    
        var ref: DatabaseReference!
        ref = Database.database().reference()
    
        ref.child("Habits").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            //getting habit key
            guard let firstKey = value?.allKeys[0] else {
                print("n")
                return }
            //using habit key to get dict
            let firstDict = value![firstKey] as! Dictionary<String,Any>
            print(firstKey)
            let rewardsNode = firstDict["Rewards"] as! Dictionary<String,Any>
            self.success = rewardsNode["Success"]! as? Int
        })
    }
    
    //To start there will only be one habit
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath) as? HabitCell{
            return cell;
        }
        return HabitCell();
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let rewardsAction = UITableViewRowAction(style: .normal, title: "Rewards") { (action, index) in
  
            
            
            //when the user crosses over on rewards the successes should be updated in firebase
            //They are already being added above
            
            //database reference 
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            //current user
            guard let user = Auth.auth().currentUser else {
                return
            }
            let uid = user.uid
            
            //Gets the Habit id
            ref.child("Habits").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? NSDictionary
                //getting habit key
                guard let firstKey = value?.allKeys[0] else {
                    print("n")
                    return }

                let firstDict = value![firstKey] as! Dictionary<String,Any>

                var success = firstDict["success"] as? Int
                
                ref.child("Habits").child(uid).child("\(firstKey)").updateChildValues(["success":success! + 1])

                self.intrinsicQuestions = ["How are you progressing in this habit?","Why do you want to continue?","How does this relate to your values?","How good do you feel(name of habit)?","What do you gain by (name of habit)"]
            })
            
            
            self.performSegue(withIdentifier: "toRewards", sender: nil)

        }
        rewardsAction.backgroundColor = UIColor.blue
        return [rewardsAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200;
    }
    
    //This is the menu button thats treated as a logout
    @IBAction func menuAsLogout(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.remove(key: KEY_UID)
        try! Auth.auth().signOut()
//        dismiss(animated: true, completion: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainLoginID") as! MainLogin
        self.present(newViewController, animated: true, completion: nil)
    }
    

}
