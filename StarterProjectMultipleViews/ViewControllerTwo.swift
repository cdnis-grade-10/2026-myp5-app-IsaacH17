/*
 
 ViewControllerTwo.swift
 
 This file will contain the code for the second viewcontroller.
 Please ensure that your code is organised and is easy to read.
 This means that you will need to both structure your code correctly,
 in addition to using the correct syntax for Swift.
 
 Unless you are told otherwise, ensure that you are using the
 camelCase syntax. For example, outputLabel and firstName are good
 examples of using the camelCase syntax.
 
 Within each class, you can see clearly identified sections denoted by
 MARK statements. These MARK statements allow you to structure and organise
 your code.
 
 - @IBOutlets should be listed under the MARK section on IBOutlets
 - Variables and constants listed under the MARK section Variables and Constants
 - Functions (including @IBActions) listed under the section on IBActions and Functions.
 
 As you develop each view controller class with Swift code, please include
 detailed comments to both demonstrate understanding, and which serve you as
 a reminder as to what your code actually does.
 
 */

import UIKit

class ViewControllerTwo: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    // MARK: - IBOutlets

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var eventTableView: UITableView!
    
    // MARK: - Variables and Constants
    
    // Setting up the search controller
    
    let searchController = UISearchController()
    
    // Creating another events list (will be used to retrieve the new list of events after the user has applied filters)
    
    var filteredList = Data.eventsList
    
    // MARK: - IBActions and Functions
    
    /*
     # of rows in the table will = filtered list / events list count (depending if the search controller is being used (whether the user is currently applying filters or not))
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //***CHECK***
        
        if searchController.isActive {
            return filteredList.count
        } else {
            return Data.eventsList.count
        }
        
    }
    
    // Inputting the actual content for each row of the table view (assigning the different labels etc. to different values of the Event struct)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Selecting the table view cell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "homepageVCCell") as! TableViewCell
        
        /*
         Getting the event from the array (filtered or full list depending on if the search controller is active)
         This just gets the event details for one event and will be repeated for all events in the array
         */
        
        let currentEvent: Data.Event
        
        if searchController.isActive {
            currentEvent = filteredList[indexPath.row]
        } else {
            currentEvent = Data.eventsList[indexPath.row]
        }
        
        // Populating the table cell with event details based on the current event
        
        tableViewCell.eventName.text = currentEvent.eventName
        tableViewCell.eventDate.text = Data.parseDateComponent(date: currentEvent.eventDate, startTime: currentEvent.eventStartTime, endTime: currentEvent.eventEndTime)
        tableViewCell.eventAge.text = "Age: " + Data.ageRangeString(ageRange: currentEvent.eventAgeRange)
        tableViewCell.eventDesc.text = "\(currentEvent.descTag1), \(currentEvent.descTag2), \(currentEvent.descTag3)"
        tableViewCell.eventImage.image = currentEvent.eventImage
        
        return tableViewCell
        
    }
    
    // Function to initialize search controller
    
    func initSearchController() {
        
        // Creating the search controller & QoL features to enhance the user's experience when using the search bar and filter buttons
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Creating the filters that will be available for selection
        
        searchController.searchBar.scopeButtonTitles = ["All", "Education", "Sports", "Arts", "Others", "13-16", "16-18", "13+", "16+"]
        searchController.searchBar.delegate = self
    }
    
    // Updating the actual results by getting the search bar keyword and filter selected, then displaying the new list of events using the fullFilter function
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let filterButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        fullFilter(searchText: searchText, scopeButton: filterButton)
    }
    
    // Function that determines how the events list is filtered, scope button is set to the user's interest category selected from the signup screen by default
    
    func fullFilter(searchText: String, scopeButton: String = Data.userInterest) {
        
        // Creating the filtered list by filtering the full events list
        
        filteredList = Data.eventsList.filter {
            
            // For each event in the list:
            
            event in
            
            /*
             Check if the event matches the filter by seeing if:
             - The selected filter category matches the actual event category OR
             - If the event name contains the category itself
             - If the filter (age range) matches the age range of the event
             Returns true or false
             */
            
            let scopeMatch = (scopeButton == Data.categoryString(category: event.category) || scopeButton == Data.ageRangeString(ageRange: event.eventAgeRange) || event.eventName.lowercased().contains(scopeButton.lowercased()))
            
            /*
             Check if the user inputted a search keyword
             If they have, the search keyword must be present in the event's name --> return true or false
             Both the scopeMatch & searchTextMatch (event name contains search keyword) must be true in order for the event to be added to the filtered list
             
             If no search keyword has been added, then the events list can be added to the filtered list as long as scopeMatch is true (the filter button's name is present in the event's name / same category / same age range)
             */
            
            if searchController.searchBar.text != "" {
                let searchTextMatch = (event.eventName.lowercased().contains(searchText.lowercased()))
                
                return scopeMatch && searchTextMatch
                
            } else {
                return scopeMatch
            }
            
        }
        
        // Showing all the events if the filter is 'all'
        
        if scopeButton == "All" {
            filteredList = Data.eventsList
        }
        
        // Reloading table view data
        
        eventTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Welcoming the user using their name & displaying the search controller
        
        usernameLabel.text = "Name: " + Data.username
        initSearchController()
        
        // Add code to filter the events list based on the user's interest
        
    }


}
