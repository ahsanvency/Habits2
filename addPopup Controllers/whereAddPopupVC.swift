//
//  whereAddPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit

class whereAddPopupVC: UIViewController {
    
    var weekArray = [Int]()
    var habitName: String?
    
    var whyLblText: String = ""
    
    var whenLblText:String = ""
    
    var whereLblText:String = ""
    
    @IBOutlet weak var whereText: fancyField!
    @IBOutlet weak var habitTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitTxt.text = habitName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let whereView = storyBoard.instantiateViewController(withIdentifier: "NewHabitVCID") as! NewHabitVC
        whereView.whereLblText = whereText.text!
        whereView.weekArray = weekArray
        whereView.whyLblText = whyLblText
        whereView.whenLblText = whenLblText

        
        self.present(whereView,animated: true, completion: nil)
    }
    
}
