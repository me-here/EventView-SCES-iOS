//
//  EventDetailViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/22/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    var event: Event!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var attendanceCount: UILabel!
    @IBOutlet var startLabel: UILabel!
    @IBOutlet var endLabel: UILabel!
    @IBOutlet var isAttending: UISwitch!
    
    /// Populate EventDetailViewController with the needed Event model..
    func preConfigure(_ event: Event) {
        self.event = event
    }
    
    // Setup the visuals of the detail VC from what is in the model.
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromEvent()
    }
    
    // Grabs what is in the event model object injects its elements into the view.
    func loadDataFromEvent() {
        locationLabel.text = event.location
        attendanceCount.text = "\(event.attending)"
        startLabel.text = event.start
        endLabel.text = event.end
        self.title = event.name
    }
    
    @IBAction func toggleAttending(_ sender: Any) {
        let increment = isAttending.isOn ? 1 : 0    // Does not decrement on off, because API does not either.
        event.attending += increment
        loadDataFromEvent()                         // reload the view according to model changes.
        guard increment > 0 else {return}
        
        // Tell the API of the update in attendance (only if we toggled from off to on, since the API does not handle decrements).
        EventAPIClient.setUserIsAttendingEventWith(eventID: "\(event.id)", handle: { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                self.showError(message: error.rawValue)
            }
        })
    }
}
