//
//  NewHabitVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/4/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit
import Firebase



class NewHabitVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    
    var habitRow: Int?
    var habitName: String?
    
    var whyLblText: String = ""
    
    var weekArray = [Int]()
    var whenLblText:String = ""
    
    var whereLblText:String = ""
    
    //Variables
    //let uid = Auth.auth().currentUser?.uid
    
    
    //Why, When, Where habit labels
    //These are the labels for the text associated with it
    //Like the label doesnot affect "Why" it affects "Better physical health"
    @IBOutlet weak var whyLbl: UILabel!
    @IBOutlet weak var whenLbl: UILabel!
    @IBOutlet weak var whereLbl: UILabel!
    
    //The Labels for the textField and the picker
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var habitPic: UIImageView!
    
    //All The TextFeilds
    @IBOutlet weak var whyTxt: UITextField!
    @IBOutlet weak var whenTxt: UITextField!
    @IBOutlet weak var whereTxt: UITextField!
    
    @IBOutlet weak var basicTxt: UITextField!
    @IBOutlet weak var intermediateTxt: UITextField!
    @IBOutlet weak var advTxt: UITextField!
    
    
    
    //creates the list for the picker view
    //Add more if you see fit
    var list = ["Running","Meditating","Waking Up Early","Coding","Journaling"]
    var list2 = ["run","meditate","wake up early","code","journal"]
    
    //Starts off with just the picker for editing
    override func viewDidLoad() {
        super.viewDidLoad()
        //Starts the screen with the habit pic being hidden
        habitPic.isHidden = true
        
        //getting values from pop up
        whyLbl.text = whyLblText
        whenLbl.text = whenLblText
        whereLbl.text = whereLblText
        
        
        //added touch events to views
        addTouchEvents()
        
        
        
    }
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return list.count
    }
    
    //Functionality for the pickerView and the textfield that works with it
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //The user cannot edit the components anymore
        self.view.endEditing(true)
        //This is the value that was selected by the picker
        return list[row]
    }
    
    //Whatever picker spot was selected the "row" will know
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //What value was selected by the user
        habitRow = row
        habitName = self.list[row];
        self.textBox.text = habitName; //Sets the name of the textBox to the habit name
        self.dropDown.isHidden = true; //Hides the Drop Down Menu because something was selected
        self.habitPic.isHidden = false;
        self.habitPic.image = UIImage(named: habitName!); //Changes the pic to correspond with the habit
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.textBox {
            self.dropDown.isHidden = false;
            habitPic.isHidden = true
            //if you dont want the users to se the keyboard type:
            textField.endEditing(true)
        }
    }
    
    @IBOutlet weak var WhyView: fancyView!
    @IBOutlet weak var WhenView: fancyView!
    @IBOutlet weak var whereView: fancyView!
    
    func addTouchEvents(){
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.onWhyViewTapped(sender:)))
        self.WhyView.addGestureRecognizer(gesture)
        
        let whenGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onWhenViewTapped(sender:)))
        self.WhenView.addGestureRecognizer(whenGesture)
        
        let whereGesture = UITapGestureRecognizer(target: self, action:  #selector (self.onWhereViewTapped(sender:)))
        self.whereView.addGestureRecognizer(whereGesture)
    }
    
    @objc func onWhyViewTapped(sender: UITapGestureRecognizer){
        
        if habitRow != nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "addPopups", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "whyPopup") as! whyPopupVC
            newViewController.whyLblText = whyLblText
            newViewController.habitName = habitName!.lowercased() + "?"
            newViewController.habitRow = habitRow
            newViewController.weekArray = weekArray
            newViewController.whenLblText = whenLblText
            newViewController.whereLblText = whereLblText
            self.present(newViewController, animated: true, completion: nil)
        } else {
            print("select box")
        }
    }
    
    @objc func onWhenViewTapped(sender: UITapGestureRecognizer){
        if habitRow != nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "addPopups", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "UIViewController-dgE-aU-RRy") as! whenAddPopupVC
            newViewController.habitName = "start " + habitName!.lowercased() + "?"
            newViewController.whyLblText = whyLblText
            newViewController.weekArray = weekArray
            newViewController.whenLblText = whenLblText
            newViewController.whereLblText = whereLblText
            self.present(newViewController, animated: true, completion: nil)
        } else {
            print("select box")
        }
    }
    
    @objc func onWhereViewTapped(sender: UITapGestureRecognizer){
        if habitRow != nil{
            let storyBoard: UIStoryboard = UIStoryboard(name: "addPopups", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "UIViewController-How-5o-Ud8") as! whereAddPopupVC
            newViewController.habitName =  list2[habitRow!].lowercased() + "?"
            newViewController.whyLblText = whyLblText
            newViewController.weekArray = weekArray
            newViewController.whenLblText = whenLblText
            newViewController.whereLblText = whereLblText
            self.present(newViewController, animated: true, completion: nil)
        } else {
            print("select box")
        }
    }
    
    
    
    @IBAction func addHabit(_ sender: Any) {
        
        
        if Auth.auth().currentUser?.uid != nil {
            
            //checks to see if txtFeilds are empty
            let valid = validateTextFeilds()
            if valid == true{
                
                //database instance
                var ref: DatabaseReference!
                ref = Database.database().reference()
                
                //current user
                guard let user = Auth.auth().currentUser else {
                    return
                }
                let uid = user.uid
                
                //getting key of habits list
                let habitRefKey = ref.child("Users").child(uid).child("Habits").childByAutoId().key
                //Values to add to Habits list
                let childUpdates = ["/Users/\(uid)/Habits/\(habitRefKey)": textBox.text]
                ref.updateChildValues(childUpdates)
                //Adding Habit to Habits node
                //This is where the information on the label needs to be changed
                ref.child("Habits").child(uid).child(habitRefKey).setValue(["Why": whyLbl.text,"When":whenLbl.text,"Where":whereLbl.text,"name":habitName])
                //Adding rewards to habit
                ref.child("Habits").child(uid).child(habitRefKey).child("Rewards").setValue(["Basic":basicTxt.text,"Int":intermediateTxt.text,"Adv":advTxt.text])
                
                //Segue
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainScreenViewCID") as! MainScreenViewC
                self.present(newViewController, animated: true, completion: nil)
                
                
            } else {
                print("error")
            }
        }
    }
    
    
    func validateTextFeilds() -> Bool{
        if (whyLbl.text == "") {
            //handel the errors properly
            print("Error1")
            return false
        }
        if (whenLbl.text == nil){
            print("Error2")
            return false
        }
        if (whereLbl.text == nil){
            print("Error3")
            return false
        }
        if (basicTxt.text == nil){
            print("Error4")
            return false
        }
        if (intermediateTxt.text == nil){
            print("Error5")
            return false
        }
        if advTxt.text == nil {
            print("Error6")
            return false
        }
        if (textBox.text == nil){
            print("Error7")
            return false
        }
        return true
    }
}


