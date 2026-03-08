//
//  ViewControllerFive.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 8/3/2026.
//

import UIKit

class ViewControllerFive: UIViewController, UICalendarSelectionSingleDateDelegate {
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    var date: DateComponents = DateComponents()
    var dateArray: [DateComponents] = []
    
    @IBAction func homepageButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.present(Data.homepageVc, animated: true, completion: nil)
    }
    
    func searchEventDateArray(eventDate: DateComponents) -> Int? {
        return Data.eventsList.firstIndex {$0.eventDate.year == eventDate.year && $0.eventDate.month == eventDate.month && $0.eventDate.day == eventDate.day}
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
//        if dateComponents in dateArray == true {
//            
//
//            
//        } else {
//            return
//        }
        
        Data.eventIndex = searchEventDateArray(eventDate: dateComponents!)!
        
        
        
        Data.missingNavBar = true
        self.dismiss(animated: true)
        self.present(Data.homepageVc, animated: true, completion: nil)
        
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        
        let year = dateComponents?.year
        
        let month = dateComponents?.month
        
        let day = dateComponents?.day
        
        for dateComp in dateArray {
            if dateComp.year == year && dateComp.month == month && dateComp.day == day {
                return true
            }
        }
        
        return false
        
    }
    
    
//    eventArrayIndex = searchEventArray(eventName: eventName.text!)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Displaying the username
        
        usernameLabel.text = "Hello, " + Data.username
        
        //*****CALENDAR****
        
        // Setting up the calendar & its design
        
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        calendarView.delegate = self
        
        // Allowing the users to select dates on the calendar
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 600),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        for event in Data.eventsList where event.isFavorited == true {

            date = event.eventDate
            dateArray.append(date)

        }
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

// Adding the decorations to the dates

extension ViewControllerFive: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        // Getting the year, month, and day of each element of the UICalendarView
        
        guard let year = dateComponents.year else {
            return nil
        }
        
        guard let month = dateComponents.month else {
            return nil
        }
        
        guard let day = dateComponents.day else {
            return nil
        }
        
        /*
         If the exact date is present within the date array (which stores the dates of the user's favorited events), then we can add the decoration dot to signify so)
         */
        
        for dateComp in dateArray {
            if dateComp.year == year && dateComp.month == month && dateComp.day == day {
                return UICalendarView.Decoration.default(color: .systemMint, size: .large)
            }
        }
        
        return nil
    }
}
