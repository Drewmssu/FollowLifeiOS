//
//  CalendarTableViewController.swift
//  FollowLife
//
//  Copyright © 2018 Hillari Zorrilla Delgado. All rights reserved.
//

import UIKit

class CalendarTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAppointmentButton(_ sender: UIBarButtonItem) {
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        // This is where you would change section header content
        return tableView.dequeueReusableCell(withIdentifier: "header")
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 44
    }*/
    
   


}
