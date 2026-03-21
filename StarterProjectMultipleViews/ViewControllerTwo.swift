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
    @IBOutlet weak var chosenFilter: UILabel!
    @IBOutlet weak var eventTableView: UITableView!
    
    // MARK: - Variables and Constants
    
    // Setting up the search controller
    
    let searchController = UISearchController()
    
    /*
     Determines whether the user has just entered this screen from another screen
     If so, then the events list needs to be refiltered based on the user's category preference selection in the signup screen (or else there will be no filters applied at all)
     */
    
    var firstTimeLoad = false
    
    // Stores the filtered list (which is the same as the events list but will be filtered based on the search keyword and filter parameters)
    
    var filteredList = Data.eventsList
    
    // MARK: - IBActions and Functions
    
    // # of rows in the table will equal the filtered list count (since the list of events we are showing in the event table view is always coming from the filtered list of events
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredList.count
        
    }
    
    // Inputting the actual content for each row of the table view (assigning the different labels etc. to different values of the Event struct)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Selecting the table view cell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "homepageVCCell") as! TableViewCell
        
        /*
         Getting the event from the filtered event list array
         This gets the event details for one event and then is repeated for all events in the array
         */
        
        let currentEvent = filteredList[indexPath.row]
        
        // Populating the table cell with event details based on the current event
        
        tableViewCell.eventName.text = currentEvent.eventName
        tableViewCell.eventDate.text = Data.parseDateComponent(date: currentEvent.eventDate, startTime: currentEvent.eventStartTime, endTime: currentEvent.eventEndTime)
        tableViewCell.eventAge.text = "Age: " + Data.ageRangeString(ageRange: currentEvent.eventAgeRange)
        tableViewCell.eventDesc.text = "\(currentEvent.descTag1), \(currentEvent.descTag2), \(currentEvent.descTag3)"
        tableViewCell.eventImage.image = currentEvent.eventImage
        
        // If the event aligns with the user's chosen user interest, then there will be a recommended tag applied to the event
        
        if Data.categoryString(category: currentEvent.category) != Data.userInterest {
            tableViewCell.recommendLabel.isHidden = true
        } else {
            tableViewCell.recommendLabel.isHidden = false
        }
        
        return tableViewCell
        
    }
    
    // When the user clicks on the event row (wants to learn more about the event):
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get the index of the row, which can be used to find the Event struct by using the index within the filtered list (as all of the events that are presented in the table view format are a part of filtered list (since the list has been filtered through)
        
        let indexPath = self.eventTableView.indexPathForSelectedRow
        let eventChosen = filteredList[indexPath!.row]
        
        /*
         Find the same Event struct within the main event array (as this never changes unlike the filtered event array) and get its index and store it
         This index will be used later to access the desired Event struct through the events list array
         */
        
        Data.eventIndex = Data.searchEventArray(eventName: eventChosen.eventName)!
        
        self.performSegue(withIdentifier: "segueFourthVC", sender: self)
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
        searchController.scopeBarActivation = .onSearchActivation
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Moving the search controller from the bottom to the top
        
        if #available(iOS 26.0, *) {
            navigationItem.searchBarPlacementAllowsToolbarIntegration = false
        }
        
        
        // Creating the filters that will be available for selection (emojis have to be used due to space constraints) - there will be a label indicating the user's filter selection to compensate
        
        searchController.searchBar.scopeButtonTitles = ["All", "📚", "⚽️", "🎭", "Misc", "13+", "16+"]
        searchController.searchBar.delegate = self
    }
    
    // Updating the actual results by getting the search bar keyword and filter selected, then displaying the new list of events using the fullFilter function
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Retrieving the search keyword from the search bar and the selected filter button
        
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        var filterButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        /*
         If firstTimeLoad = true (when there are no prior search filters since the user just came to this screen from another VC), then the filter applide will be the user's selected interest chosen in the signup screen
         */
        
        if firstTimeLoad == true {
            
            switch Data.userInterest {
            case "Education":
                filterButton = searchBar.scopeButtonTitles![1]
            case "Sports":
                filterButton = searchBar.scopeButtonTitles![2]
            case "Arts":
                filterButton = searchBar.scopeButtonTitles![3]
            case "Others":
                filterButton = searchBar.scopeButtonTitles![4]
            default:
                break
            }
            
        }
        
        firstTimeLoad = false
        
        /*
         Filtering the events list
         If the user has already selected a search text keyword and/or filter button, then this will be what is used to filter the events list array
         If no filters are used, then only filterButton will be inputted (which is the user's category preference as determined above)
         */
        
        fullFilter(searchText: searchText, scopeButton: filterButton)
        
    }
    
    // Function that filters the events list using the search keyword and/or filter chosen
    
    func fullFilter(searchText: String, scopeButton: String) {
        
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
             
             When a filter is selected, the label will tell the user what filter they have chosen (especially because the emojis used in the different filters may make it difficult to understand (for the user) as to what they actually represent)
             */
            
            /*
             First checking to see if the filter button selected is of an age range instead of a category
             - If 13+ is selected, then see if the event's age is either 13+ or 13-16, return true if so
             - If 16+ is selected, then see if the event's age is either 16+ or 16-18, return true if so
             */
            
            var ageRangeTrue = false
            
            if scopeButton == "13+" {
                chosenFilter.text = "Filter Selection: 13+"
                if Data.ageRangeString(ageRange: event.eventAgeRange) == "13+" || Data.ageRangeString(ageRange: event.eventAgeRange) == "13-16" {
                    ageRangeTrue = true
                }
            } else if scopeButton == "16+" {
                chosenFilter.text = "Filter Selection: 16+"
                if Data.ageRangeString(ageRange: event.eventAgeRange) == "16+" || Data.ageRangeString(ageRange: event.eventAgeRange) == "16-18" {
                    ageRangeTrue = true
                }
            }
            
            /*
             Looking at the category filters
             - Checking if the selected filter matches the event's category using the criteria mentioned above - if so, then filter category = event category criteria is met
             */
            
            var correctFilterCategory = false
            
            switch scopeButton {
            case "All":
                correctFilterCategory = true
                chosenFilter.text = "Filter Selection: All"
            case "📚":
                chosenFilter.text = "Filter Selection: Education"
                if Data.categoryString(category: event.category) == "Education" {
                    correctFilterCategory = true
                }
            case "⚽️":
                chosenFilter.text = "Filter Selection: Sports"
                if Data.categoryString(category: event.category) == "Sports" {
                    correctFilterCategory = true
                }
            case "🎭":
                chosenFilter.text = "Filter Selection: Arts"
                if Data.categoryString(category: event.category) == "Arts" {
                    correctFilterCategory = true
                }
            case "Misc":
                chosenFilter.text = "Filter Selection: Others/Misc"
                if Data.categoryString(category: event.category) == "Others" {
                    correctFilterCategory = true
                }
            default:
                break
            }
            
            // Seeing if any of the 3 criteria have been met (not possible for all to be true, eg. a filter can only be categorical or age range based thus correctFilterCategory and ageRangeTrue can't both be true)
            
            let scopeMatch = (correctFilterCategory == true || ageRangeTrue == true || event.eventName.lowercased().contains(scopeButton.lowercased()))
            
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
        
        // Reloading table view data
        
        eventTableView.reloadData()
        
    }
    
    /*
     If the user is traversing via the homepage screen to reach the event details page, then directly direct them to the event details VC using the segue
     */
    
    override func viewDidAppear(_ animated: Bool) {
        if Data.traversalOnly == true {
            self.performSegue(withIdentifier: "segueFourthVC", sender: self)
        }
        
        /*
         If the user is entering this screen from another screen that isn't the signup screen (eg. event creator screen), because the viewDidLoad is already triggered, we can only determine if the user came from another screen using viewDidAppear
         If the user is coming from another screen, then we need to reload the events list using their category preference
         */
        
        firstTimeLoad = true
        updateSearchResults(for: self.searchController)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Adding a black border to the table view
        
        eventTableView.layer.borderWidth = 2
        
        // Corner radius to the table view
        
        self.eventTableView.layer.cornerRadius = 10
        
        // Welcoming the user using their name & displaying the search controller
        
        usernameLabel.text = "Hello, " + Data.username
        
        initSearchController()
        
        // Updating the events list according to the user's selected preference in the singup screen

        firstTimeLoad = true
        updateSearchResults(for: self.searchController)
        
    }
}
