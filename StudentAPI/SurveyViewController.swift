//
//  SurveyViewController.swift
//  StudentAPI
//
//  Created by Steven Patterson on 7/28/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var songTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let name = nameTextField.text,
        response = songTextField.text where name.characters.count > 0 && response.characters.count > 0 else {return}
        
        SurveyController.sendSurvey(name, response: response)
        nameTextField.text = ""
        songTextField.text = ""
    }
    
}
