//
//  HabitCell.swift
//  Habits
//
//  Created by Ahsan Vency on 1/5/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import Firebase

class HabitCell: UITableViewCell {

    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var habitPic: UIImageView!
    @IBOutlet weak var whyLbl: UILabel!
    @IBOutlet weak var whenLbl: UILabel!
    @IBOutlet weak var whereLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            guard let user = Auth.auth().currentUser else {
                print("User not found")
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
                
                //getting dict values and assigning them to labels
                self.nameLbl.text = firstDict["name"] as? String
                self.whyLbl.text = firstDict["Why"] as? String
                self.whenLbl.text = firstDict["When"] as? String
                self.whereLbl.text =  firstDict["Where"] as? String
                self.habitPic.image = UIImage(named: "\(self.nameLbl.text!)2" )
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
        })
        
        
    }
    
    func reload(){
        guard let user = Auth.auth().currentUser else {
            print("User not found")
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
            
            //getting dict values and assigning them to labels
            self.nameLbl.text = firstDict["name"] as? String
            self.whyLbl.text = firstDict["Why"] as? String
            self.whenLbl.text = firstDict["When"] as? String
            self.whereLbl.text =  firstDict["Where"] as? String
            self.habitPic.image = UIImage(named: self.nameLbl.text! )
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
}
