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
        var latLocation: Double
        var longLocation: Double
        var descTag1: String
        var descTag2: String
        var descTag3: String
        var eventDesc: String
        var eventImage: UIImage
        var isFavorited = false
    }
    
}
