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
        locationLabel.text = event.location
        attendanceCount.text = "\(event.attending)"
        startLabel.text = event.start
        endLabel.text = event.end
        self.title = event.name
    }
    
    @IBAction func toggleAttending(_ sender: Any) {
    }
}
