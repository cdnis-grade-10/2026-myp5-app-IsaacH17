//
//  ViewControllerFive.swift
//  StarterProjectMultipleViews
//
//  Created by Isaac on 8/3/2026.
//

import UIKit

class ViewControllerFive: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    var date: DateComponents = DateComponents()
    var dateArray: [DateComponents] = []
    
    @IBAction func homepageButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.present(Data.homepageVc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameLabel.text = "Hello, " + Data.username
        
        //*****CALENDAR****
        
        
        let calendarView = UICalendarView()
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        //calendarView.availableDateRange
        calendarView.delegate = self
        
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 600),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        
        

        
        
        for event in Data.eventsList where event.isFavorited == true {
            
            let

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

extension ViewControllerFive: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
//        guard var month = DateComponents else {
//            return nil
//        }
        
        guard let year = dateComponents.year else {
            return nil
        }
        
        guard let month = dateComponents.month else {
            return nil
        }
        
        guard let day = dateComponents.day else {
            return nil
        }
        
        for dateComp in dateArray {
            if dateComp.year == year && dateComp.month == month && dateComp.day == day {
                return UICalendarView.Decoration.default(color: .systemMint, size: .large)
            }
        }
        
        return nil
    }
}
