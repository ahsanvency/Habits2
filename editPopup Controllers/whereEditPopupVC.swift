//
//  whereEditPopupVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/21/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import Firebase

class whereEditPopupVC: UIViewController {
    @IBOutlet weak var whereText: fancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if whereText.text != ""{
            
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
                ref.child("Habits").child(uid).child("\(firstKey)").updateChildValues(["Where":self.whereText.text])
            }) { (error) in
                print(error.localizedDescription)
            }
            
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let whenView = storyBoard.instantiateViewController(withIdentifier: "MainScreenViewCID") as! MainScreenViewC
                
                self.present(whenView,animated: true, completion: nil)
            
        }
        
        
        
    }
}
