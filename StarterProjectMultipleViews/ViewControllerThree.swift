/*
 
 ViewControllerThree.swift
 
 This file will contain the code for the third viewcontroller.
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

class ViewControllerThree: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var ageRangeField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var startTimeField: UITextField!
    @IBOutlet weak var endTimeField: UITextField!
    @IBOutlet weak var latField: UITextField!
    @IBOutlet weak var longField: UITextField!
    @IBOutlet weak var tag1Field: UITextField!
    @IBOutlet weak var tag2Field: UITextField!
    @IBOutlet weak var tag3Field: UITextField!
    @IBOutlet weak var descField: UITextView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    
    // MARK: - Variables and Constants
    
    let agePickerView = UIPickerView()
    let categoryPickerView = UIPickerView()
    
    let ageOptions = ["13+", "16+", "13-16", "16-18"]
    let categoryOptions = ["Education", "Sports", "Arts", "Others"]
    
    let datePicker = UIDatePicker()
    let startTimePicker = UIDatePicker()
    let endTimePicker = UIDatePicker()
    
    // MARK: - IBActions and Functions
    
    @IBAction func imagePickerButton(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
        
    }
    
    @IBAction func submitButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainVCNav")
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        imageField.image = image
        
        dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == agePickerView {
            return ageOptions.count
        } else {
            return categoryOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePickerView {
            return ageOptions[row]
        } else {
            return categoryOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agePickerView {
            ageRangeField.text = ageOptions[row]
        } else {
            categoryField.text = categoryOptions[row]
        }
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        timeFormatter.dateFormat = "HH:mm"
        
        switch sender {
        case datePicker:
            dateField.text = dateFormatter.string(from: sender.date)
        case startTimePicker:
            startTimeField.text = timeFormatter.string(from: sender.date)
        case endTimePicker:
            endTimeField.text = timeFormatter.string(from: sender.date)
        default:
            break
        }
        // when date picker is changed, this function will be run
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        errorMessage.isHidden = true
        
        ageRangeField.inputView = agePickerView
        agePickerView.delegate = self
        
        categoryField.inputView = categoryPickerView
        categoryPickerView.delegate = self
        
        //date logic
        
        datePicker.minimumDate = Date()
        
        datePicker.datePickerMode = .date
        startTimePicker.datePickerMode = .time
        endTimePicker.datePickerMode = .time
        
        dateField.inputView = datePicker
        startTimeField.inputView = startTimePicker
        endTimeField.inputView = endTimePicker
        
        for picker in [datePicker, startTimePicker, endTimePicker] {
            picker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
            picker.preferredDatePickerStyle = .wheels
        }
        
    }
}
