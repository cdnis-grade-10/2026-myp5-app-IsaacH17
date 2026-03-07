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
    
    var retrievedEvent: Data.Event?
    
    //print(retrievedEvent)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        print(Data.filteredList)
//        print(eventIndex)
        
        //print("POST: \(eventIndex), \(Data.filteredList)")
        
        imageView.image = retrievedEvent?.eventImage
        eventName.text = retrievedEvent?.eventName
        
        organizerDateTimeLabel.text = "Organizer: \(Data.username) | \(Data.parseDateComponent(date: retrievedEvent!.eventDate, startTime: retrievedEvent!.eventStartTime, endTime: retrievedEvent!.eventEndTime))"
        
        ageCatLabel.text = "Age: \(Data.ageRangeString(ageRange: retrievedEvent!.eventAgeRange)) | Category: \(Data.categoryString(category: retrievedEvent!.category))"
        
        descLabel.text = retrievedEvent?.eventDesc
        word1.text = retrievedEvent?.descTag1
        word2.text = retrievedEvent?.descTag2
        word3.text = retrievedEvent?.descTag3
        
        
        
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
