//
//  whyPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit

class whyPopupVC: UIViewController {
    
    var whyLblText: String = ""
    var habitName: String = ""
    
    @IBOutlet weak var whyText: UITextField!
    @IBOutlet weak var nameOfhabit: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        whyText.text = whyLblText
        nameOfhabit.text = habitName
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let valid = validateTextFeilds()
        if valid{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let whyInfo = storyBoard.instantiateViewController(withIdentifier: "NewHabitVCID") as! NewHabitVC
            whyInfo.whyLblText = whyText.text!
            self.present(whyInfo,animated: true, completion: nil)
        }
        
    }
    
    func validateTextFeilds() -> Bool{
        if (whyText.text == "") {
            //handle the errors properly
            print("Error1")
            return false
        }
        return true
    }
}
