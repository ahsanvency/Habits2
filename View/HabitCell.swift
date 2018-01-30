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
                self.whereLbl.text =  firstDict["Where"] as? String
                self.habitPic.image = UIImage(named: "\(self.nameLbl.text!)2" )
                
                
                let daysDict: Dictionary = [1:"Sun",2:"Mon",3:"Tue",4:"Wed",5:"Thu",6:"Fri",7:"Sat"]
                
                func getDayOfWeek()->Int {
                    let time = Date()
                    
                    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                    let myComponents = myCalendar.components(.weekday, from: time)
                    let weekDay = myComponents.weekday
                    return weekDay!
                }
                let cDay = getDayOfWeek()
                print(cDay) // 4 = Wednesday
                
                
                let fbTime  =  firstDict["When"] as? String
                
                let fbParseTime = fbTime?.split(separator: " ")//
                let fbLength = fbParseTime?.count
                let fbTimeVal = fbParseTime![fbLength! - 2 ..< fbLength! ]
                print("array time", fbTimeVal)
                var fbNewTime = ""
                for x in fbTimeVal {
                    fbNewTime += x + " "
                }
                print(fbNewTime)
//                self.whenLbl.text = daysDict[weekday]
                
                let workDaysNS: NSArray = firstDict["freq"]! as! NSArray
                var workDaysArray: Array = [Any]()
                for x in workDaysNS{
                    workDaysArray.append(x)
                }
                
                print(workDaysArray)
                
                //start get next workout
                var gotWorkOut = false
                //Check 1
                for x in workDaysArray{
                    print(x)
                    print(cDay)
                    var check = x as! Int
                    
                    if  check == cDay{
                        
                        self.whenLbl.text = daysDict[cDay]! + " " + fbNewTime
                        gotWorkOut = true
                    }
                }
                
                //check 2
                if  gotWorkOut == false {
                    var lowerDays = [Int]()
                    var higherDays = [Int]()
                    
                    for x in workDaysArray{
                        var value = x as! Int
                        if value < cDay {
                            lowerDays.append(value)
                        } else {
                            higherDays.append(value)
                        }
                        
                    }
                    
                    if higherDays.count != 0 {
                        self.whenLbl.text = daysDict[higherDays[0]]! + " " + fbNewTime
                        gotWorkOut = true
                        
                    } else if lowerDays.count != 0 {
                        self.whenLbl.text = daysDict[lowerDays[0]]! + " " + fbNewTime
                        gotWorkOut = true
                        
                    } else {
                        self.whenLbl.text = daysDict[cDay]! + " " + fbNewTime
                        gotWorkOut = true
                        
                    }
                    
                    
                }
                
                
                

                
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

