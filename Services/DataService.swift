//
//  DataService.swift
//  Habits
//
//  Created by Ahsan Vency on 1/9/18.
//  Copyright © 2018 ahsan vency. All rights reserved.
//

import Foundation
import UIKit
import Firebase


let DB_BASE = Database.database().reference()

class DataService {
    
    static let ds = DataService()
    
    //Starts at the main base
    private var _REF_BASE = DB_BASE
    
    //Goes from the main base to the posts
    private var _REF_USERS = DB_BASE.child("Users")

    
    var REF_BASE: DatabaseReference {
        return _REF_BASE;
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS;
    }
    
    func createFirebaseDBUser (uid: String, userData: Dictionary<String, AnyObject>){
        
        //This will create the user and update the values
        //The uid is the user id that is created upon the creation of a new user
        REF_USERS.child(uid).updateChildValues(userData)
    }
}
