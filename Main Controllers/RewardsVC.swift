//
//  RewardsVC.swift
//  Habits
//
//  Created by Ahsan Vency on 1/4/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import UIKit

class RewardsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    struct slotComp{
        var image: UIImage!
        var color: String
    }
    
    var images = [slotComp]() //array for the reel on the slots
    var counter = 0 //counter variable for the different columns
    var comp1 = "" //What the row ends up being in the first column
    var comp2 = "" //What the row ends up being in the second column
    var comp3 = "" //What the row ends up being in the third column
    var rows = 0; //Handles the randRow assignments
    var randomVariable: Int!
    
    @IBOutlet weak var slotMachine: UIPickerView!
    @IBOutlet weak var lblWin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblWin.isHidden = true //Starts off by hiding the win label
        
        //Creates the image variables and sets up the names
        let green = slotComp(image: UIImage(named: "Green"), color: "green")
        let red = slotComp(image: UIImage(named: "Red"), color: "red")
        let blue = slotComp(image: UIImage(named: "Blue"), color: "blue")
        let white = slotComp(image: UIImage(named: "White"), color: "white")
        
        //adding the images to the array
        images = [white,red, white, blue, red, white, red, white, green, white, blue, white, red, blue, white, red, red, white, blue, red, white, red, white, green, white, blue, white, red, blue, white, red, red, white, blue, red, white, red, white, green, white, blue, white, red, blue, white, red, white]
        
        slotMachine.isUserInteractionEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func spin(_ sender: Any) {
        //runs the random spin function at the time interval indicated
        //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: "randomSpin", userInfo: nil, repeats: true)
        
        
        lblWin.isHidden = true //Hides the label at the beginning of each spin
        
        //Resets the comps
        comp1 = ""
        comp2 = ""
        comp3 = ""
        counter = 0
        
        //This spins each one of the pickers, was needed before the timer was used
        randomSpin()
        randomSpin()
        randomSpin()
    }
    
    
    func randomSpin(){
        let randRow = Int(arc4random_uniform(UInt32(315))) //Creates a random number for the picker to stop on
        switch randRow%100 {
        case 0..<10:
            rows = 1
        case 10..<12:
            rows = 1
        case 13..<20:
            rows = 3
        case 20..<30:
            rows = 4
        case 30..<34:
            rows = 5
        case 34..<45:
            rows = 5
        case 45..<53:
            rows = 7
        case 53..<58:
            rows = 8
        case 58..<66:
            rows = 9
        case 66..<73:
            rows = 10
        case 73..<76:
            rows = 11
        case 76..<86:
            rows = 12
        case 86..<92:
            rows = 13
        case 92..<96:
            rows = 14
//        case 96..<101:
//            rows = 15
//        case 101..<110:
//            rows = 16
//        case 110..<112:
//            rows = 17
//        case 113..<120:
//            rows = 18
//        case 120..<130:
//            rows = 19
//        case 130..<134:
//            rows = 20
//        case 134..<145:
//            rows = 21
//        case 145..<153:
//            rows = 22
//        case 153..<158:
//            rows = 23
//        case 158..<166:
//            rows = 24
//        case 166..<173:
//            rows = 25
//        case 173..<176:
//            rows = 26
//        case 176..<186:
//            rows = 27
//        case 186..<192:
//            rows = 28
//        case 192..<196:
//            rows = 29
        default:
            rows = 15
        }
        
        if randRow - 200 > 0{
            rows += 30;
        }else if randRow - 100 > 0{
            rows += 15;
        }
        print(randRow,rows)
        //"rows" sets the image displayed on the picker
        slotMachine.selectRow(rows, inComponent: counter, animated: true)
        
        //"rows" sets the value on the picker, the physical value
        self.pickerView(slotMachine, didSelectRow: rows, inComponent: counter)
        
        counter += 1 //increases the counter to go to the next column and spin it
        if counter == 3 { //Once it reaches all the columns it moves it back to normal
            //timer.invalidate() //Stops the timer from going on
            counter = 0 //resets the counter to the first column
        }
    }
    
    //Still confused as to how the component part works with this
    //The component must be the column and the row the row number for that component
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        //sets the comp variables to the ones below
        switch component {
        case 0:
            comp1 = images[row].color
            break
        case 1:
            comp2 = images[row].color
            break
        case 2:
            comp3 = images[row].color
            break
        default:
            break
        }
        if comp1 == "red" && comp2 == "red" && comp3 == "red"{
            lblWin.isHidden = false
            lblWin.text = "Red Winner"
        }
        else if (comp1 == "red" || comp2 == "red" || comp3 == "red") && comp1 != "white" && comp2 != "white" && comp3 != "white" && !((comp1 == "blue" && comp2 == "blue") || (comp2 == "blue" && comp3 == "blue") || (comp1 == "blue" && comp3 == "blue")){
            lblWin.isHidden = false
            lblWin.text = "Red Winner"
        }
        else if comp1 == comp2 && comp2 == comp3 && comp3 == "blue"{
            lblWin.isHidden = false
            lblWin.text = "Blue Winner"
        }
        else if ((comp1 == "blue" && comp2 == "blue") || (comp2 == "blue" && comp3 == "blue") || (comp1 == "blue" && comp3 == "blue")) && (comp1 != "white" && comp2 != "white" && comp3 != "white"){
            lblWin.isHidden = false
            lblWin.text = "Blue Winner"
        }
        else if comp1 == comp2 && comp2 == comp3 && comp3 == "green"{
            lblWin.isHidden = false
            lblWin.text = "Green Winner"
        }
        else {
            lblWin.isHidden = true
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIImageView(image: images[row].image) //Sets the row to this particular image
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 130;
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3; 
    }
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
