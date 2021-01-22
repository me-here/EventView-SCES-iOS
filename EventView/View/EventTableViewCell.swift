//
//  EventTableViewCell.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/21/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    
    func configure(_ event: Event) {
        nameLabel.text = event.name
        locationLabel.text = event.location
        startDateLabel.text = formatTime(event.start)
        endDateLabel.text = formatTime(event.end)
    }
    
    /// Format date from YYYY-MM-DD HH:MM:SS --> short time..
    func formatTime(_ date: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let parsedDate = inputDateFormatter.date(from: date) else {
            return ""
        }
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH:mm"
        return outputDateFormatter.string(from: parsedDate)
    }
}
