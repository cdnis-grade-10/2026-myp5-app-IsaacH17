//
//  ViewControllerFour.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 7/3/2026.
//

import UIKit
import MapKit
import CoreLocation

class ViewControllerFour: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var organizerDateTimeLabel: UILabel!
    @IBOutlet weak var ageCatLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var word1: UILabel!
    @IBOutlet weak var word2: UILabel!
    @IBOutlet weak var word3: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var favoriteOutlet: UIBarButtonItem!
    
    // Setting up the event array index (to find the index of which this event belongs to in the events list)
    
    var eventArrayIndex = 0
    
    // Gets the user's selected event they want to learn more about from the 2nd VC
    
    var retrievedEvent: Data.Event?
    
    // Setting up the map pin coordinate
    
    var coordinate = CLLocationCoordinate2D()
    
    // Code to deal with the favorite button
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        
        // Find the event in the eventsList array through seeing which Event struct in the array has the same eventName
        
        eventArrayIndex = searchEventArray(eventName: eventName.text!)!
        
        // Checking to see if the favorite button has been clicked alreday (it will show 'favorite' if the event hasn't been favorited yet)
        
        if favoriteOutlet.title == "Favorite" {
            favoriteOutlet.title = "Favorited!"
            
            // Using the eventArrayIndex to find the exact location of the event struct associated with this event and changing its isFavorited property to true
            
            Data.eventsList[eventArrayIndex].isFavorited = true
            
        } else {
            
            // If the event is already favorited and the user clicks on the button again, then the text will change and will signify that the user has unfavorited the event
            
            favoriteOutlet.title = "Favorite"
            Data.eventsList[eventArrayIndex].isFavorited = false
        }
    }
    
    // Code to add the actual pin representation onto the map
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        
        // Setting the pin's coordinates and title (event name) and adding it to the map view
        
        pin.coordinate = coordinate
        pin.title = retrievedEvent?.eventName
        mapView.addAnnotation(pin)
    }
    
    func searchEventArray(eventName: String) -> Int? {
        return Data.eventsList.firstIndex { $0.eventName == eventName}
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Setting the map pin's coordinates based on the event's lat. and long. values
        
        coordinate = CLLocationCoordinate2D(latitude: retrievedEvent!.latLocation, longitude: retrievedEvent!.longLocation)
        
        // Zooming the map to the coordinate's (event location) region
        
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        
        mapView.delegate = self
        
        // Adding the actual pin onto the map
        
        addCustomPin()
        
        /*
         Populating the information with the event details (which are all retrieved from retrievedEvent (which is retrieved from chosenEvent in 2nd VC which determines the event the user wants to learn more about)
         Some data is converted into strings through parsing functions
         */
        
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
