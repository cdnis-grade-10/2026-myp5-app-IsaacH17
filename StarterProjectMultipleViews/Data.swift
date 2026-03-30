//
//  Data.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 4/3/2026.
//

import Foundation
import UIKit

class Data {
    
    // Selected username & user interest from the signup screen
    
    static var username = ""
    static var userInterest = ""
    
    // Enum for the category options on the signup page
    
<<<<<<< HEAD
<<<<<<< HEAD
//    enum category {
//        case education
//        case sports
//        case arts
//        case others
//    }
    
//    // Reformatting the enum input into an actual string
//    
//    static func categoryString(category: category) {
//        switch category {
//        case .education:
//            userInterest = "Education"
//        case .sports:
//            userInterest = "Sports"
//        case .arts:
//            userInterest = "Others"
//        case .others:
//            return
//        }
//    }
    
    // Creating the full event struct with all required parameters
    
    struct Data {
        var eventName: String
        var eventAgeRange: String
        var category: String
        var eventDate: Date
        var eventStartTime: Date
        var eventEndTime: Date
=======
=======
>>>>>>> event-creator
    enum category {
        case education
        case sports
        case arts
        case others
    }
    
    enum ageRange {
        case age13Up
        case age16Up
        case age13to16
        case age16to18
    }
    
    /*
     Reformatting the enum inputs into actual strings
     Using the enum input as an argument and returning the string instead of assigning a variable to the string allows for flexibility (func. can be reused across different screens)
     */

    static func categoryString(category: category) -> String {
        switch category {
        case .education:
            return "Education"
        case .sports:
            return "Sports"
        case .arts:
            return "Arts"
        case .others:
            return "Others"
        }
    }
    
    static func ageRangeString(ageRange: ageRange) -> String {
        switch ageRange {
        case .age13Up:
            return "13+"
        case .age13to16:
            return "13-16"
        case .age16Up:
            return "16+"
        case .age16to18:
            return "16-18"
        }
    }
    
    // Creating the full event struct and assigning each variable to the relevant data type
    
    struct Event {
        var eventName: String
        var eventAgeRange: Data.ageRange
        var category: Data.category
        var eventDate: DateComponents
        var eventStartTime: DateComponents
        var eventEndTime: DateComponents
<<<<<<< HEAD
>>>>>>> homepage-screen
=======
>>>>>>> event-creator
        var latLocation: Double
        var longLocation: Double
        var descTag1: String
        var descTag2: String
        var descTag3: String
        var eventDesc: String
        var eventImage: UIImage
        var isFavorited = false
    }
    
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> event-creator
    // Creating an array of the Events struct (all of the app's events will be stored in here)
    
    static var eventsList = [
        Event(eventName: "Teaching Math to Children", eventAgeRange: .age13Up, category: .education, eventDate: DateComponents(year: 2026, month: 3, day: 26), eventStartTime: DateComponents(hour: 15, minute: 00), eventEndTime: DateComponents(hour: 18, minute: 00), latLocation: 22.24, longLocation: 114.17, descTag1: "Fun", descTag2: "Lively", descTag3: "Engaging", eventDesc: "Come teach math to primary school students!", eventImage: UIImage(named: "TeachingMath")!),
        Event(eventName: "Hong Kong Breadrun", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 3, day: 29), eventStartTime: DateComponents(hour: 08, minute: 00), eventEndTime: DateComponents(hour: 09, minute: 30), latLocation: 22.33, longLocation: 114.16, descTag1: "Enriching", descTag2: "Inspiring", descTag3: "", eventDesc: "Come breadrun with other volunteers!", eventImage: UIImage(named: "HongKongBreadrun")!),
        Event(eventName: "Play Sports with Children", eventAgeRange: .age16to18, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 10), eventStartTime: DateComponents(hour: 17, minute: 00), eventEndTime: DateComponents(hour: 19, minute: 00), latLocation: 22.28, longLocation: 114.18, descTag1: "Active", descTag2: "Refreshing", descTag3: "", eventDesc: "Come play sports with undepriviledged children!", eventImage: UIImage(named: "PlaySports")!)
    ]
    
    // Creating a function to parse the DateComponents from the Events struct into an actual, readable string format
    // Users must give the 3 different DateComponents from the Events struct to be able to extract the actual date of the event + start & end time of the event
    
    static func parseDateComponent(date: DateComponents, startTime: DateComponents, endTime: DateComponents) -> String {
        
        // Assigning variables which convert each of the DateComponents into a Date type format
        
        let date = Calendar.current.date(from: date)
        let startTime = Calendar.current.date(from: startTime)
        let endTime = Calendar.current.date(from: endTime)
        
        // Assigning a date format (telling how we want the actual string that shows the date to look like after we convert it from the Date format --> String format)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        // Using the date format to convert the Dates --> Strings then returning it as one whole string
        
        let actualDate = dateFormatter.string(from: date!)
        let actualStart = timeFormatter.string(from: startTime!)
        let actualEnd = timeFormatter.string(from: endTime!)
        
        return "\(actualDate), \(actualStart) - \(actualEnd)"
        
    }
    
}

// A class that stores all of the outlets which are present in each table view cell

class TableViewCell: UITableViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventAge: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
<<<<<<< HEAD
>>>>>>> homepage-screen
=======
>>>>>>> event-creator
}
