//
//  whereAddPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit

class whereAddPopupVC: UIViewController {
    
    var habitNameStr: String?
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var whereText: fancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        habitName.text = habitNameStr
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let whereView = storyBoard.instantiateViewController(withIdentifier: "NewHabitVCID") as! NewHabitVC
        whereView.whereLblText = whereText.text!
        self.present(whereView,animated: true, completion: nil)
    }
    
}
