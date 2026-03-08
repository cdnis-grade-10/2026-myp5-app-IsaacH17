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
    var chosenEvent: Data.Event?
    
    // MARK: - IBActions and Functions
    
    /*
     # of rows in the table will = filtered list / events list count (depending if the search controller is being used (whether the user is currently applying filters or not))
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Returning the filtered list of events --> updateSearchResults is called once this screen is loaded in so the filteredList will show the new list based on the filter (the user's selected user interest)
        
        return Data.filteredList.count
        
    }
    
    // Inputting the actual content for each row of the table view (assigning the different labels etc. to different values of the Event struct)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Selecting the table view cell
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "homepageVCCell") as! TableViewCell
        
        /*
         Getting the event from the filtered event list array
         This gets the event details for one event and then is repeated for all events in the array
         */
        
        let currentEvent = Data.filteredList[indexPath.row]
        
        // Populating the table cell with event details based on the current event
        
        tableViewCell.eventName.text = currentEvent.eventName
        tableViewCell.eventDate.text = Data.parseDateComponent(date: currentEvent.eventDate, startTime: currentEvent.eventStartTime, endTime: currentEvent.eventEndTime)
        tableViewCell.eventAge.text = "Age: " + Data.ageRangeString(ageRange: currentEvent.eventAgeRange)
        tableViewCell.eventDesc.text = "\(currentEvent.descTag1), \(currentEvent.descTag2), \(currentEvent.descTag3)"
        tableViewCell.eventImage.image = currentEvent.eventImage
        
        /*
         Assigning the learn more button tag for each row as the index row
         When pressed, it will run the objc function learnMoreTapped
         */
        
        tableViewCell.learnMoreButton.tag = indexPath.row
        
        tableViewCell.learnMoreButton.addTarget(self, action: #selector(learnMoreTapped(_:)), for: .touchUpInside)
        
        // If the event aligns with the user's chosen user interest, then there will be a recommended tag applied to the event
        
        if Data.categoryString(category: currentEvent.category) != Data.userInterest {
            tableViewCell.recommendLabel.isHidden = true
        } else {
            tableViewCell.recommendLabel.isHidden = false
        }
        
        return tableViewCell
        
    }
    
    /*
     Uses the button tag to retrieve the exact event struct from the filtered events list (so to access all of the relevant information associated with the event)
     Segue to fourth VC afterwards (which initiates the override prepare function below)
     */
    
    @objc func learnMoreTapped(_ sender: UIButton){
        
        chosenEvent = Data.filteredList[sender.tag]
        
        performSegue(withIdentifier: "segueFourthVC", sender: self)
        
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
        } else {
            // Fallback on earlier versions
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
         If the search controller is inactive (essentially when no filters have been applied at all which usually happens when the homepage screen is first loaded in):
         The filter will be the user's selected interest (so that the events list is filtered based on the user's interest preference)
         */
        
        if searchController.isActive == false {
            
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
        
        // Filtering the events list
        
        fullFilter(searchText: searchText, scopeButton: filterButton)
        
    }
    
    // Function that determines how the events list is filtered, scope button is set to the user's interest category selected from the signup screen by default
    
    func fullFilter(searchText: String, scopeButton: String) {
        
        // Creating the filtered list by filtering the full events list
        
        Data.filteredList = Data.eventsList.filter {
            
            // For each event in the list:
            
            event in
            
            /*
             Check if the event matches the filter by seeing if:
             - The selected filter category matches the actual event category OR
             - If the event name contains the category itself
             - If the filter (age range) matches the age range of the event
             Returns true or false
             
             When a filter is selected, the label will tell the user what filter they have chosen (especially because emojis may be difficult to understand)
             */
            
            /*
             Looking at the age filters (by default, it is determined that the age range filter doesn't match the event's age range unless proven)
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
             - Checking if the selected filters match the event's category - if so then filter category = event category criteria is met
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
            
            // Seeing if any of the 3 criteria have been met
            
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Welcoming the user using their name & displaying the search controller
        
        usernameLabel.text = "Name: " + Data.username
        initSearchController()
        
        // Updating the homepage screen events list to filter the events based on the user's selected interest when the user loads into the screen for the 1st time
        
        updateSearchResults(for: self.searchController)
        
    }
    
    /*
     When the segue to the 4th VC is performed (when the learn more button is pressed):
     Send the chosen event (which contains the Event struct details for the selected event) to the retrieved event variable in the 4th VC
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let eventDetailsVC = segue.destination as? ViewControllerFour {
            eventDetailsVC.retrievedEvent = chosenEvent
        }
    }

}
