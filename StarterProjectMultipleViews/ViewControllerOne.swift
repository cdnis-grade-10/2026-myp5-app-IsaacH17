/*
 
 ViewControllerOne.swift
 
 This file will contain the code for the first viewcontroller.
 Please ensure that your code is organised and is easy to read.
 This means that you will need to both structure your code correctly,
 in addition to using the correct syntax for Swift.
 
 Unless you are told otherwise, ensure that you are using the
 camelCase syntax. For example, outputLabel and firstName are good
 examples of using the camelCase syntax.
 
 Within each class, you can see clearly identified sections denoted by
 MARK statements. These MARK statements allow you to structure and organise
 your code.
 
 - @IBOutlets should be listed under the MARK section on IBOutlets
 - Variables and constants listed under the MARK section Variables and Constants
 - Functions (including @IBActions) listed under the section on IBActions and Functions.
 
 As you develop each view controller class with Swift code, please include
 detailed comments to both demonstrate understanding, and which serve you as
 a reminder as to what your code actually does.
 
 */

import UIKit

class ViewControllerOne: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var userSelection: UILabel!
    
    // MARK: - Variables and Constants
    
    var selectedInterest = false
    
    // MARK: - IBActions and Functions
    
    @IBAction func interestButton(_ sender: UIButton) {
        
        // Checking if the user has selected a button
        
        if sender.tag != 0 {
            selectedInterest = true
        }
        
        // Assigning the category as a text to a variable if the user has selected a button
        
        /*
         If the user has selected a button:
         - Use the button's tag to determine the category the user selected and assign it to the userInterest variable (this will be used later to automatically filter the homepage screen according to the category
         - Using a label to tell the user what button they selected (for confirmation) using enums
         */
        
        if selectedInterest == true {
            
            switch sender.tag {
            case 1:
                Data.userInterest = Data.categoryString(category: Data.category.education)
            case 2:
                Data.userInterest = Data.categoryString(category: Data.category.sports)
            case 3:
                Data.userInterest = Data.categoryString(category: Data.category.arts)
            default:
                return
            }
            
            userSelection.text = "Your Selection: \(Data.userInterest)"
            
        }
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        // Checking if all inputs have been inputted (username and selected user interest)
        
        if userTextField.text != "" && selectedInterest == true {
            
            // Assigning the username to a global variable & moving to the next screen
            
            Data.username = userTextField.text!
            performSegue(withIdentifier: "segueToSecondVC", sender: self)
        } else {
            
            // Showing the error message if inputs haven't been fully completed
            
            errorMessage.isHidden = false
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Hiding the error message by default
        
        errorMessage.isHidden = true
    }

}

