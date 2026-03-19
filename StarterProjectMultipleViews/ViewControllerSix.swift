//
//  ViewControllerSix.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 9/3/2026.
//

import UIKit

class ViewControllerSix: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Stores the # of events the user has favorited (signed up for)

    var eventNo = 0
    
    // Stores the array of events that have been favorited as the table view will be populated with this information
    
    var favoritedEvents: [Data.Event] = []
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var eventNumber: UILabel!
    @IBOutlet weak var congratsMessage: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBAction func homepageButton(_ sender: UIButton) {
        performSegue(withIdentifier: "sixthToHomeScreen", sender: self)
    }
    
    // # of rows = # of event entries in the favorited events array
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Selecting the table view cell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "profileEventsCell") as! TableViewCell
        
        /*
         Getting the event from the favorited event list array
         This gets the event details for one event and then is repeated for all events in the array
         */
        
        let currentEvent = favoritedEvents[indexPath.row]
        
        // Populating the table cell with the event name and date
        
        tableViewCell.dateLabel.text = Data.parseDateComponent(date: currentEvent.eventDate, startTime: currentEvent.eventStartTime, endTime: currentEvent.eventEndTime, needTime: false)
        tableViewCell.eventLabel.text = currentEvent.eventName
        
        return tableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*
         If the row is selected, then it means the user wants to learn more about the event
         Find our the index path and use this to access the chosen event's event name
         Use the event name to search for the index of this Event struct within the eventsList array and save it
         The event index will be used by the event details VC to display the correct event
         traversalOnly = true and go to the homepage screen (the homepage screen will automatically direct the usre to the event details screen because traversalOnly = true)
         */
        
        let indexPath = self.eventsTableView.indexPathForSelectedRow?.row
        
        Data.eventIndex = Data.searchEventArray(eventName: favoritedEvents[indexPath!].eventName)!
        
        Data.traversalOnly = true
        
        performSegue(withIdentifier: "sixthToHomeScreen", sender: self)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Adding a black border to the table view
        
        eventsTableView.layer.borderWidth = 2
        
        // Corner radius to the table view
        
        self.eventsTableView.layer.cornerRadius = 10
        
        // Welcoming the user using their name
        
        usernameLabel.text = "Hello, " + Data.username
        
        // Check all events in the events list, if it is favorited, then add it to the favorited events list so that it can be displayed on the table view later onwards
        
        for event in Data.eventsList {
            if event.isFavorited == true {
                favoritedEvents.append(event)
            }
        }
        
        // Count the total # of favorited events then display it as a congratulatory message to congratulate the user on this achievement
        
        eventNo = favoritedEvents.count
        
        eventNumber.text = String(eventNo)
        congratsMessage.text = "Well done for signing up to \(eventNo) events! Keep it up!"

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
