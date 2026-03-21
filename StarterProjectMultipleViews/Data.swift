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
    
    /*
     User wants to learn more about a specific event --> finds the index for this event within the event array list and stores it as a variable
     Used in homepage screen, profile screens where the user wants to learn more about a specific event
     */
    
    static var eventIndex = 0
    
    // Used to perform a segue from the profile screen to the event details screen via the homepage screen (not possible to segue without going through the homepage screen or else the 3rd and 4th VCs will lose their nav bars)
    
    static var traversalOnly = false
    
    // Enum for the category & age range options (used in the Event struct, signup page etc.)
    
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
     Function that reformats the enum inputs into actual strings
     Using the enum input as an argument and returning the string instead of assigning a variable to the string allows for flexibility (func. can be reused across different screens)
     2 functions (one to reformat the category enum into a string and another to reformat the age range enum into a string)
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
        var latLocation: Double
        var longLocation: Double
        var descTag1: String
        var descTag2: String
        var descTag3: String
        var eventDesc: String
        var eventImage: UIImage
        var isFavorited = false
    }
    
    // Creating an array of the Events struct (all of the app's events will be stored in here)
    
    static var eventsList = [
        Event(eventName: "Teaching Math to Children", eventAgeRange: .age13Up, category: .education, eventDate: DateComponents(year: 2026, month: 3, day: 30), eventStartTime: DateComponents(hour: 15, minute: 00), eventEndTime: DateComponents(hour: 18, minute: 00), latLocation: 22.24, longLocation: 114.17, descTag1: "Fun", descTag2: "Lively", descTag3: "Engaging", eventDesc: "Come teach math to primary school students!", eventImage: UIImage(named: "TeachingMath")!),
        
        Event(eventName: "Hong Kong Breadrun", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 4, day: 21), eventStartTime: DateComponents(hour: 08, minute: 00), eventEndTime: DateComponents(hour: 09, minute: 30), latLocation: 22.33, longLocation: 114.16, descTag1: "Enriching", descTag2: "Inspiring", descTag3: "Cool", eventDesc: "Come breadrun with other volunteers!", eventImage: UIImage(named: "HongKongBreadrun")!),
        
        Event(eventName: "Play Sports with Children", eventAgeRange: .age16to18, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 10), eventStartTime: DateComponents(hour: 17, minute: 00), eventEndTime: DateComponents(hour: 19, minute: 00), latLocation: 22.28, longLocation: 114.18, descTag1: "Active", descTag2: "Refreshing", descTag3: "Awesome", eventDesc: "Come play sports with undepriviledged children!", eventImage: UIImage(named: "PlaySports")!),
        
        Event(eventName: "Cooking for a Cause", eventAgeRange: .age16to18, category: .others, eventDate: DateComponents(year: 2026, month: 4, day: 10), eventStartTime: DateComponents(hour: 09, minute: 00), eventEndTime: DateComponents(hour: 12, minute: 00), latLocation: 22.295184, longLocation: 114.234219, descTag1: "Tasty", descTag2: "Warm", descTag3: "Interactive", eventDesc: "Come learn from talented chefs and cook for a group of elderly residents!", eventImage: UIImage(named: "CookingForACause")!),
        
        Event(eventName: "Beach Cleanup", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 4, day: 11), eventStartTime: DateComponents(hour: 14, minute: 30), eventEndTime: DateComponents(hour: 18, minute: 30), latLocation: 22.237708, longLocation: 114.196185, descTag1: "Rewarding", descTag2: "Hands-on", descTag3: "Conservation", eventDesc: "Come make Repulse Bay Beach clean again!", eventImage: UIImage(named: "BeachCleanup")!),
        
        Event(eventName: "Hiking Trip", eventAgeRange: .age13Up, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 12), eventStartTime: DateComponents(hour: 08, minute: 00), eventEndTime: DateComponents(hour: 17, minute: 00), latLocation: 22.3821835, longLocation: 114.2318881, descTag1: "Scenic", descTag2: "Nature", descTag3: "Majestic", eventDesc: "Enjoy a breathtaking hike to raise money for charity.", eventImage: UIImage(named: "HikingTrip")!),
        
        Event(eventName: "Singing Talent Show", eventAgeRange: .age13to16, category: .arts, eventDate: DateComponents(year: 2026, month: 5, day: 01), eventStartTime: DateComponents(hour: 10, minute: 00), eventEndTime: DateComponents(hour: 16, minute: 30), latLocation: 22.2801969, longLocation: 114.1694339, descTag1: "Exciting", descTag2: "Musical", descTag3: "Unforgettable", eventDesc: "Show off your singing skills and raise money for charity!", eventImage: UIImage(named: "SingingTalentShow")!),
        
        Event(eventName: "Chinese for Children", eventAgeRange: .age13to16, category: .education, eventDate: DateComponents(year: 2026, month: 4, day: 30), eventStartTime: DateComponents(hour: 12, minute: 00), eventEndTime: DateComponents(hour: 13, minute: 00), latLocation: 22.2834019, longLocation: 114.197991, descTag1: "Helpful", descTag2: "Educational", descTag3: "Cultural", eventDesc: "Come teach children how to read and write in Chinese!", eventImage: UIImage(named: "ChineseForChildren")!),
        
        Event(eventName: "Interactive English Class", eventAgeRange: .age16to18, category: .education, eventDate: DateComponents(year: 2026, month: 5, day: 31), eventStartTime: DateComponents(hour: 15, minute: 30), eventEndTime: DateComponents(hour: 17, minute: 00), latLocation: 22.2726731, longLocation: 114.1255704, descTag1: "Engaging", descTag2: "Helpful", descTag3: "Immersive", eventDesc: "Come teach underpriviledged children how to read English!", eventImage: UIImage(named: "InteractiveEnglishClass")!),
        
        Event(eventName: "Dance Showdown", eventAgeRange: .age13Up, category: .arts, eventDate: DateComponents(year: 2026, month: 5, day: 22), eventStartTime: DateComponents(hour: 18, minute: 00), eventEndTime: DateComponents(hour: 21, minute: 00), latLocation: 22.2868373, longLocation: 114.1515944, descTag1: "Energetic", descTag2: "Creative", descTag3: "Fun", eventDesc: "Come support the dance showdown event where all funds go towards charity!", eventImage: UIImage(named: "DanceShowdown")!),
        
        Event(eventName: "Volunteer with Pets", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 4, day: 05), eventStartTime: DateComponents(hour: 09, minute: 30), eventEndTime: DateComponents(hour: 12, minute: 00), latLocation: 22.3113724, longLocation: 114.1775911, descTag1: "Cute", descTag2: "Loving", descTag3: "Happy", eventDesc: "Come take care of cute dogs and cats!", eventImage: UIImage(named: "VolunteerWithPets")!),
        
        Event(eventName:"Volleyball Coaching", eventAgeRange: .age16Up, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 25), eventStartTime: DateComponents(hour: 16, minute: 00), eventEndTime: DateComponents(hour: 17, minute: 30), latLocation: 22.2757214, longLocation: 114.1874028, descTag1: "Inclusive", descTag2: "Active", descTag3: "Electric", eventDesc: "Mentor young children and teach them how to play volleyball!", eventImage: UIImage(named: "VolleyballCoaching")!),
        
        Event(eventName: "Photography Class", eventAgeRange: .age16to18, category: .arts, eventDate: DateComponents(year: 2026, month: 4, day: 19), eventStartTime: DateComponents(hour: 20, minute: 00), eventEndTime: DateComponents(hour: 22, minute: 00), latLocation: 22.2760386, longLocation: 114.1454573, descTag1: "Breathtaking", descTag2: "Creative", descTag3: "Stunning", eventDesc: "Learn how to take breathtaking photos. All raised funds go towards charity!", eventImage: UIImage(named: "PhotographyClass")!),
        
        Event(eventName: "Sports Game Class", eventAgeRange: .age13Up, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 03), eventStartTime: DateComponents(hour: 19, minute: 00), eventEndTime: DateComponents(hour: 20, minute: 30), latLocation: 22.356466, longLocation: 114.1078774, descTag1: "Intense", descTag2: "Joyful", descTag3: "Engaging", eventDesc: "Interact with disabled children and play different sports with them!", eventImage: UIImage(named: "SportsGameClass")!),
        
        Event(eventName: "Packing Food for Elders", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 4, day: 17), eventStartTime: DateComponents(hour: 11, minute: 30), eventEndTime: DateComponents(hour: 14, minute: 30), latLocation: 22.3389256, longLocation: 114.148668, descTag1: "Kind", descTag2: "Helpful", descTag3: "Warm", eventDesc: "Help make a difference by preparing foor for the elderly!", eventImage: UIImage(named: "PackingFoodForElders")!)
    ]
    
    // Creating a function to parse the DateComponents from the Events struct into an actual, readable string format
    // Users must give the 3 different DateComponents from the Events struct to be able to extract the actual date of the event + start & end time of the event
    
    static func parseDateComponent(date: DateComponents, startTime: DateComponents, endTime: DateComponents, needTime: Bool = true) -> String {
        
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
        
        if needTime == true {
            return "\(actualDate), \(actualStart) - \(actualEnd)"
        } else {
            return actualDate
        }
    }
    
    // A function which is able to find the index of the Event struct within the events list using the event name
    
    static func searchEventArray(eventName: String) -> Int? {
        return Data.eventsList.firstIndex { $0.eventName == eventName}
    }
    
}

// A class that stores all of the outlets which are present in different table view cells across different screens

class TableViewCell: UITableViewCell {
    
    // Homepage screen table view
    
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventAge: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    // Profile events page table view
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
}
