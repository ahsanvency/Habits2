//
//  whyPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit

class whyPopupVC: UIViewController {

    
    @IBOutlet weak var whyText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let valid = validateTextFeilds()
        if valid{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let whyInfo = storyBoard.instantiateViewController(withIdentifier: "NewHabitVCID") as! NewHabitVC
            whyInfo.whyLblText = whyText.text!
//            if let whyTxt = whyText.text{
//                whyInfo.whyLbl.text = whyTxt
//            }else{
//                whyInfo.whyLbl.text = "WHY WONT THIS WORK"
//            }
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
