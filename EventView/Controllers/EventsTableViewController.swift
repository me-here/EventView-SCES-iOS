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
                self.showError(message: error.rawValue)
            }
        })
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell", for: indexPath) as? EventTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(eventList[indexPath.row])
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController else {return}
            guard let rowTapped = tableView.indexPathForSelectedRow?.row else {return}
            detailVC.preConfigure(eventList[rowTapped])
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        CredentialManager().deleteUserCredential()
        guard let loginVC = storyboard?.instantiateInitialViewController() else
        {
            return
        }
        loginVC.modalPresentationStyle = .fullScreen
//        loginVC.modalTransitionStyle = .flipHorizontal
        present(loginVC, animated: true, completion: nil)
    }
}
