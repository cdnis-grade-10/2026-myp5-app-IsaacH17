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
<<<<<<< HEAD
<<<<<<< HEAD
=======
    @IBOutlet weak var userSelection: UILabel!
>>>>>>> homepage-screen
=======
    @IBOutlet weak var userSelection: UILabel!
>>>>>>> event-creator
    
    // MARK: - Variables and Constants
    
    var selectedInterest = false
<<<<<<< HEAD
<<<<<<< HEAD
    //var userCategory: Data.category
=======
>>>>>>> homepage-screen
=======
>>>>>>> event-creator
    
    // MARK: - IBActions and Functions
    
    @IBAction func interestButton(_ sender: UIButton) {
        
        // Checking if the user has selected a button
        
        if sender.tag != 0 {
            selectedInterest = true
        }
        
        // Assigning the category as a text to a variable if the user has selected a button
        
<<<<<<< HEAD
<<<<<<< HEAD
        switch sender.tag {
        case 1:
            Data.userInterest = "Education"
        case 2:
            Data.userInterest = "Sports"
        case 3:
            Data.userInterest = "Arts"
        default:
            return
        }
        
=======
=======
>>>>>>> event-creator
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
            case 4:
                Data.userInterest = Data.categoryString(category: Data.category.others)
            default:
                return
            }
            
            userSelection.text = "Your Selection: \(Data.userInterest)"
            
        }
<<<<<<< HEAD
>>>>>>> homepage-screen
=======
>>>>>>> event-creator
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        
        // Checking if all inputs have been inputted (username and selected user interest)
        
        if userTextField.text != "" && selectedInterest == true {
            
<<<<<<< HEAD
<<<<<<< HEAD
            // Assigning the username to a variable & moving to the next screen
=======
            // Assigning the username to a global variable & moving to the next screen
>>>>>>> homepage-screen
            
            Data.username = userTextField.text!
            performSegue(withIdentifier: "segueToSecondVC", sender: self)
=======
            // Assigning the username to a global variable & moving to the next screen
            
            Data.username = userTextField.text!
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVCNav")
            self.present(vc, animated: true, completion: nil)
            
>>>>>>> event-creator
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

