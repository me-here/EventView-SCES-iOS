//
//  EventsTableViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/21/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    var eventList: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventAPIClient.getEventList(handle: { result in
            switch result {
            case .success(let events):
                self.eventList = events
                self.tableView.reloadData()
            case .failure(let error):
                print("failed with \(error)")
            }
        })
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        print(eventList[indexPath.row].location)
        cell.configure(eventList[indexPath.row])
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
