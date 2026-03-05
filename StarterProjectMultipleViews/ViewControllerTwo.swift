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
    
    let searchController = UISearchController()
    var filteredList = Data.eventsList
    
    // MARK: - IBActions and Functions
    
    // Telling the # of rows in the table view (determined based on the # of Event struct entries in the eventsList array)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return filteredList.count
        } else {
            return Data.eventsList.count
        }
        
    }
    
    // Inputting the actual content for each row of the table view (assigning the different labels etc. to different values of the Event struct)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "homepageVCCell") as! TableViewCell
        
        let currentEvent: Data.Event
        
        if searchController.isActive {
            currentEvent = filteredList[indexPath.row]
        } else {
            currentEvent = Data.eventsList[indexPath.row]
        }
        
        tableViewCell.eventName.text = currentEvent.eventName
        tableViewCell.eventDesc.text = "\(currentEvent.descTag1), \(currentEvent.descTag2), \(currentEvent.descTag3)"
        
        return tableViewCell
        
    }
    
    func initSearchController() {
        
        // Quality of life to enhance the user's experience when using the search bar and filter buttons
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Education", "Sports", "Arts", "Others", "13-16", "16-18", "13+", "16+"]
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let filterButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        fullFilter(searchText: searchText, scopeButton: filterButton)
    }
    
    func fullFilter(searchText: String, scopeButton: String = "All") {
        
        filteredList = Data.eventsList.filter {
            
            // NEED TO FIX LOGIC
            
            event in
            let scopeMatch = (scopeButton == "All" || event.eventName.lowercased().contains(scopeButton.lowercased()))
            
            //let scopeMatch = (scopeButton == "All" || event.category == scopeButton || event.eventAgeRange == scopeButton)
            
            if searchController.searchBar.text != "" {
                let searchTextMatch = (event.eventName.lowercased().contains(searchText.lowercased()) || event.eventDesc.lowercased().contains(searchText.lowercased()))
                
                return scopeMatch && searchTextMatch
                
            } else {
                return scopeMatch
            }
            
        }
        
        eventTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usernameLabel.text = "Name: " + Data.username
        
        initSearchController()
    }


}
