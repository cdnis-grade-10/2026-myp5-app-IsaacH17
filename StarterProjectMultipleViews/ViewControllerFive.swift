//
//  ViewControllerFive.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 8/3/2026.
//

import UIKit

class ViewControllerFive: UIViewController, UICalendarSelectionSingleDateDelegate {
    

    @IBOutlet weak var usernameLabel: UILabel!
    
    // Used for the calendar
    
    var date: DateComponents = DateComponents()
    
    // Stores of all the dates that are required to have a decoration (meaning there is an event on that day that the user has favorited)
    
    var dateArray: [DateComponents] = []
    
    // Traverses to the homepage screen
    
    @IBAction func homepageButton(_ sender: UIButton) {
        performSegue(withIdentifier: "fifthToHomeScreen", sender: self)
    }
    
    /*
     If a date has been selected, check which Event struct in the eventsList array contains the exact same date
     Necessary as when a date is selected, the user wants to find out the event associated with the date. By doing this, we identify the event in question in the eventsList array.
     */
    
    func searchEventDateArray(eventDate: DateComponents) -> Int? {
        return Data.eventsList.firstIndex {$0.eventDate.year == eventDate.year && $0.eventDate.month == eventDate.month && $0.eventDate.day == eventDate.day}
    }
    
    /*
     If a date has been selected:
     Find the event index of the event within the eventsList array
     Set traversalOnly to true and go to the homepage screen
     - To go to the event details page (which is the goal since selecting the date it supposed to then show the actual event associated with the event), we must go through the homepage VC to reach the event details page or else the event creator & event details page will lose their nav bar
     - By setting it to true, the homepage screen will understand that the user is trying to reach the event details page and thus direct them there immediately
     */
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
        Data.eventIndex = searchEventDateArray(eventDate: dateComponents!)!
        
        Data.traversalOnly = true
        
        performSegue(withIdentifier: "fifthToHomeScreen", sender: self)
        
    }
    
    // Checks to see which dates can be selected (if there is a favorited event on that day) and which can't
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        
        // Getting the individual year, month, day for each date in the calendar
        
        let year = dateComponents?.year
        let month = dateComponents?.month
        let day = dateComponents?.day
        
        /*
         If the current date is present within the date array (there is a favorited event with the exact same dates), then it can be selected
         Else, that date will be disabled for selection
         */
        
        for dateComp in dateArray {
            if dateComp.year == year && dateComp.month == month && dateComp.day == day {
                return true
            }
        }
        
        return false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Displaying the username
        
        usernameLabel.text = "Hello, " + Data.username
        
        // Setting up the calendar, its design, other QoL (eg. preventing dates in the past)
        
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
        
        // Adding the calendar and giving it constraints
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 500),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 285)
        ])
        
        /*
         Logic to determine which dates will have the green dot (to signify the user's favorited event is held on that day)
         Checks all events in the events list --> if favorited, then the DateComponents of that date will be added to the dateArray
         */
        
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
        
        let year = dateComponents.year
        let month = dateComponents.month
        let day = dateComponents.day
        
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
