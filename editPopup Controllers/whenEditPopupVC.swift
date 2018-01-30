//
//  whenEditPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl
import Firebase

class whenEditPopupVC: UIViewController {
    var weekArray = [Int]()
    var timeDict:Dictionary = [String:Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let indexSet = NSMutableIndexSet()
        weekArray.forEach(indexSet.add)
        segmentedControl.selectedSegmentIndexes = indexSet as IndexSet!
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var segmentedControl: MultiSelectSegmentedControl!
    
    @IBAction func segmentSelected(_ sender: Any) {
        
        weekArray = []
        
        for x in segmentedControl.selectedSegmentIndexes{
            print(x)
            weekArray.append(Int(x))
        }
        
        
    }
    
    @IBAction func saveButton(_ sender: Any) {

        let time = timePicker.date
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: time)
        
        guard let hour = components.hour else
        {   print("error")
            return
        }
        guard let minute = components.minute else
        {
            print("error")
            return
        }
        
        
        var daysOfWeekList = ["m","t","w","th","f","sa","su"]
        var daysOfWeekStr = ""
        for x in weekArray{
            daysOfWeekStr += daysOfWeekList[x] + " "
        }
        
        
        var timeStr = ""
        if hour > 12 {
            timeStr += String(hour - 12) + ":"
            if minute < 10{
                timeStr +=  "0" + String(minute) + " PM"
                
            } else {
                timeStr += String(minute) + " PM"
            }
            
        }else {
            timeStr += String(hour - 12) + ":"
            if minute < 10{
                timeStr +=  "0" + String(minute) + " PM"
                
            } else {
                timeStr += String(minute) + " AM"
            }
        }
        
        if weekArray.count != 0{
            //database instance
            var ref: DatabaseReference!
            ref = Database.database().reference()
            
            //current user
            guard let user = Auth.auth().currentUser else {
                return
            }
            let uid = user.uid
            
            ref.child("Habits").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                guard let firstKey = value?.allKeys[0] else {
                    print("n")
                    return }
                let strToUpdate = daysOfWeekStr + timeStr
                ref.child("Habits").child(uid).child("\(firstKey)").updateChildValues(["When":strToUpdate])
                ref.child("Habits").child(uid).child("\(firstKey)").updateChildValues(["freq":self.weekArray])
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let whenView = storyBoard.instantiateViewController(withIdentifier: "MainScreenViewCID") as! MainScreenViewC

            self.present(whenView,animated: true, completion: nil)
        }
        
    }
}
