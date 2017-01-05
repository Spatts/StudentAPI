//
//  ResponseTableViewController.swift
//  StudentAPI
//
//  Created by Steven Patterson on 7/28/16.
//  Copyright © 2016 Steven Patterson. All rights reserved.
//

import UIKit

class ResponseTableViewController: UITableViewController {
    
    var surveys: [Survey] = []

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        SurveyController.getResponses { (surveys) in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.surveys = surveys
                self.tableView.reloadData()
            })
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return surveys.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("responseCell", forIndexPath: indexPath)

        let survey = surveys[indexPath.row]
        cell.textLabel?.text = survey.name
        cell.detailTextLabel?.text = survey.response
        
        return cell
    }
}
