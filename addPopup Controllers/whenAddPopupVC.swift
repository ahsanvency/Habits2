//
//  whenAddPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import MultiSelectSegmentedControl

class whenAddPopupVC: UIViewController {
    
    var weekArray = [Int]()
    var timeDict:Dictionary = [String:Int]()
    var habitName: String?
    
    var whyLblText: String = ""
    
    var whenLblText:String = ""
    
    var whereLblText:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameOfHabit.text = habitName
        
        //        segmentedControl.selectedSegmentIndexes = [NSIndexSet indexSetWithIndex:1];
        
    }
    
    @IBOutlet weak var nameOfHabit: UILabel!
    
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
        
        timeDict["hour"] = hour
        timeDict["minute"] = minute
        var daysOfWeekList = ["m","t","w","th","f","sa","su"]
        var daysOfWeekStr = ""
        for x in weekArray{
            daysOfWeekStr += daysOfWeekList[x] + " "
        }
        var timeStr = ""
        if hour > 12 {
            timeStr += String(hour - 12) + ":"
            timeStr += String(minute) + " PM"
        } else {
            timeStr += String(hour - 12) + ":"
            timeStr += String(minute) + " AM"
        }
        
        
        if weekArray.count != 0{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let whenView = storyBoard.instantiateViewController(withIdentifier: "NewHabitVCID") as! NewHabitVC
            whenView.weekArray = weekArray
            whenView.whenLblText = daysOfWeekStr + timeStr
            whenView.whereLblText = whereLblText
            whenView.whyLblText = whyLblText
            self.present(whenView,animated: true, completion: nil)
        }
        
    }
    
}
