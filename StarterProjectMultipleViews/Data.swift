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
    
    // Array of events
    
    static var eventsList = [
        Event(eventName: "Teaching Math to Children", eventAgeRange: .age13Up, category: .education, eventDate: DateComponents(year: 2026, month: 3, day: 26), eventStartTime: DateComponents(hour: 15, minute: 00), eventEndTime: DateComponents(hour: 18, minute: 00), latLocation: 22.24, longLocation: 114.17, descTag1: "Fun", descTag2: "Lively", descTag3: "Engaging", eventDesc: "Come teach math to primary school students!", eventImage: UIImage(named: "TeachingMath")!),
        Event(eventName: "Hong Kong Breadrun", eventAgeRange: .age16Up, category: .others, eventDate: DateComponents(year: 2026, month: 3, day: 29), eventStartTime: DateComponents(hour: 08, minute: 00), eventEndTime: DateComponents(hour: 09, minute: 30), latLocation: 22.33, longLocation: 114.16, descTag1: "Enriching", descTag2: "Inspiring", descTag3: "", eventDesc: "Come breadrun with other volunteers!", eventImage: UIImage(named: "HongKongBreadrun")!),
        Event(eventName: "Play Sports with Children", eventAgeRange: .age16to18, category: .sports, eventDate: DateComponents(year: 2026, month: 4, day: 10), eventStartTime: DateComponents(hour: 17, minute: 00), eventEndTime: DateComponents(hour: 19, minute: 00), latLocation: 22.28, longLocation: 114.18, descTag1: "Active", descTag2: "Refreshing", descTag3: "", eventDesc: "Come play sports with undepriviledged children!", eventImage: UIImage(named: "PlaySports")!)
    ]
    
}

class TableViewCell: UITableViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventAge: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
}
