//
//  EventsTableViewController.swift
//  EventView
//
//  Created by Mihir Thanekar on 1/21/21.
//  Copyright © 2021 Mihir Thanekar. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    // Stores the list of events we get from the API.
    var eventList: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        loadEventList()
    }
    
    // Configures the pull to refresh to reload the table view.
    // Helpful Blog: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
    private func setupRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadEventList), for: .valueChanged)
    }
    
    // Fetches the events from the API and reloads the table with that data.
    @objc private func loadEventList() {
        EventAPIClient.getEventList(handle: { result in
            self.tableView.refreshControl?.endRefreshing()
            
            switch result {
            case .success(let events):
                self.eventList = events
                self.tableView.reloadData()
            case .failure(let error):
                self.showError(message: error.rawValue)
            }
        })
    }
    
    // Tapping on a row in the table configures the detail VC with the Event model data it needs.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventDetailSegue" {
            guard let detailVC = segue.destination as? EventDetailViewController else { return }
            guard let rowTapped = tableView.indexPathForSelectedRow?.row else { return }
            detailVC.preConfigure(eventList[rowTapped])
        }
    }
    
    // Logout, forget credential, and come back to the initial VC.
    @IBAction func logoutPressed(_ sender: Any) {
        CredentialManager().deleteUserCredential()
        guard let loginVC = storyboard?.instantiateInitialViewController() else { return }
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
}

// MARK: - Table view data source
extension EventsTableViewController {
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
}
