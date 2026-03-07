//
//  ViewControllerFour.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 7/3/2026.
//

import UIKit

class ViewControllerFour: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var organizerDateTimeLabel: UILabel!
    @IBOutlet weak var ageCatLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var word3: UILabel!
    
    
    
    var eventIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(Data.filteredList)
        print(eventIndex)
        
        imageView.image = Data.filteredList[eventIndex].eventImage
        eventName.text = Data.filteredList[eventIndex].eventName
        
        organizerDateTimeLabel.text = "Organizer: \(Data.username) | \(Data.parseDateComponent(date: Data.filteredList[eventIndex].eventDate, startTime: Data.filteredList[eventIndex].eventStartTime, endTime: Data.filteredList[eventIndex].eventEndTime))"
        
        ageCatLabel.text = "Age: \(Data.ageRangeString(ageRange: Data.filteredList[eventIndex].eventAgeRange)) | Category: \(Data.categoryString(category: Data.filteredList[eventIndex].category))"
        
        descLabel.text = Data.filteredList[eventIndex].eventDesc
        word1.text = Data.filteredList[eventIndex].descTag1
        word2.text = Data.filteredList[eventIndex].descTag2
        word3.text = Data.filteredList[eventIndex].descTag3
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
