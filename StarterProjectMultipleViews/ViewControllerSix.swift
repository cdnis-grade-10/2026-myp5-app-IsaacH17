//
//  ViewControllerSix.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 9/3/2026.
//

import UIKit

class ViewControllerSix: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var eventNo = 0
    var favoritedEvents: [Data.Event] = []
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var eventNumber: UILabel!
    @IBOutlet weak var congratsMessage: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    
    @IBAction func homepageButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.dismiss(animated: true)
        self.present(Data.homepageVc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Selecting the table view cell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "profileEventsCell") as! TableViewCell
        
        /*
         Getting the event from the filtered event list array
         This gets the event details for one event and then is repeated for all events in the array
         */
        
        let currentEvent = favoritedEvents[indexPath.row]
        
        // Populating the table cell with event details based on the current event
        
        tableViewCell.dateLabel.text = Data.parseDateComponent(date: currentEvent.eventDate, startTime: currentEvent.eventStartTime, endTime: currentEvent.eventEndTime, needTime: false)
        tableViewCell.eventLabel.text = currentEvent.eventName
        
        // If the event aligns with the user's chosen user interest, then there will be a recommended tag applied to the event
        
        return tableViewCell
        
    }
    
    func searchEventArray(eventName: String) -> Int? {
        return Data.eventsList.firstIndex { $0.eventName == eventName}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = self.eventsTableView.indexPathForSelectedRow?.row
        
        Data.eventIndex = searchEventArray(eventName: favoritedEvents[indexPath!].eventName)!
        
        Data.missingNavBar = true
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)

        self.present(Data.homepageVc, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameLabel.text = Data.username
        
        for event in Data.eventsList {
            if event.isFavorited == true {
                favoritedEvents.append(event)
            }
        }
        
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
