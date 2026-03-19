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
    
    // Setting a variable which stores the retrieved event (essentially the user's chosen event)
    
    var retrievedEvent: Data.Event?
    
    // Setting up the map pin coordinate
    
    var coordinate = CLLocationCoordinate2D()
    
    // Code to deal with the favorite button (changing its appearance and setting this parameter in the Event struct to be true / false)
    
    @IBAction func favoriteButton(_ sender: UIBarButtonItem) {
        
        // Checking to see if the favorite button has been clicked alreday (it will show 'favorite' if the event hasn't been favorited yet)
        
        if favoriteOutlet.title == "Favorite" {
            favoriteOutlet.title = "Favorited!"
            
            // Changing the button text color
            
            favoriteOutlet.tintColor = .systemYellow
            
            // Use Data.eventIndex (which stores the index of the current event within the events list) and change the isFavorited parameter of the struct
            
            Data.eventsList[Data.eventIndex].isFavorited = true
            
        } else {
            
            // If the event is already favorited and the user clicks on the button again, then the text will change and will signify that the user has unfavorited the event
            
            favoriteOutlet.title = "Favorite"
            favoriteOutlet.tintColor = .black
            Data.eventsList[Data.eventIndex].isFavorited = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // This is only necessary for the homepage VC to know that it needs to redirect users to this page, must be switched off or else when the user backs out to the homepage screen, they will be sent back into this screen (resulting in a loop)
        
        Data.traversalOnly = false
        
        // Getting the current event using Data.eventIndex (which stores the index of the current event within the eventsList array
        
        retrievedEvent = Data.eventsList[Data.eventIndex]
        
        // Setting the map pin's coordinates based on the event's lat. and long. values
        
        coordinate = CLLocationCoordinate2D(latitude: retrievedEvent!.latLocation, longitude: retrievedEvent!.longLocation)
        
        // Zooming the map to the coordinate's (event location) region
        
        mapView.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)
        
        mapView.delegate = self
        
        // Adding the actual pin onto the map
        
        addCustomPin()
        
        /*
         Populating the information with the event details about the user's chosen event
         Include details like the event image, event name, date and time, etc.
         */
        
        imageView.image = retrievedEvent?.eventImage
        eventName.text = retrievedEvent?.eventName
        
        organizerDateTimeLabel.text = "Organizer: \(Data.username) | \(Data.parseDateComponent(date: retrievedEvent!.eventDate, startTime: retrievedEvent!.eventStartTime, endTime: retrievedEvent!.eventEndTime))"
        
        ageCatLabel.text = "Age: \(Data.ageRangeString(ageRange: retrievedEvent!.eventAgeRange)) | Category: \(Data.categoryString(category: retrievedEvent!.category))"
        
        descLabel.text = retrievedEvent?.eventDesc
        word1.text = retrievedEvent?.descTag1
        word2.text = retrievedEvent?.descTag2
        word3.text = retrievedEvent?.descTag3
        
        // Showing that the event has already been favorited if this is true by checking the isFavorited parameter of the struct
        
        if retrievedEvent!.isFavorited == true {
            favoriteOutlet.title = "Favorited!"
            favoriteOutlet.tintColor = .systemYellow
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
