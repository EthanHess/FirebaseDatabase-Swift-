//
//  PersonTableViewController.swift
//  Firedatabase-Swift-
//
//  Created by Ethan Hess on 3/17/16.
//  Copyright © 2016 Ethan Hess. All rights reserved.
//

import UIKit

class PersonTableViewController: UITableViewController {
    
    var items = [NSDictionary]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFirebaseData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        configureCell(cell, indexPath: indexPath)
        tableViewStyle(cell)

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
           let dictionary = items[indexPath.row]
           let name = dictionary[nameKey] as! String
            
           let profile = firebase.ref.childByAppendingPath(name)
           profile.removeValue()
        }
    }
    

    
    //Self explanatory
    
    func loadFirebaseData() {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        firebase.observeEventType(.Value, withBlock: { (snapshot) -> Void in
            
            var temporaryItemsArray = [NSDictionary]()
            
            for item in snapshot.children {
                
                let child = item as! FDataSnapshot
                let dictionary = child.value as! NSDictionary
                
                temporaryItemsArray.append(dictionary)
            }
            
            self.items = temporaryItemsArray
            self.tableView.reloadData()
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
        })
        
    }
    
    //Configuration
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        let dictionary = items[indexPath.row]
        
        cell.textLabel?.text = dictionary[nameKey] as? String
        
        let dobTimeInterval = dictionary[DOBKey] as! NSTimeInterval
        configureTimeInterval(dobTimeInterval, cell: cell)
        
        let base64String = dictionary[base64Key] as! String
        populateImage(base64String, cell: cell)
        
    }
    
    func configureTimeInterval(interval: NSTimeInterval, cell: UITableViewCell) {
        
        let date = NSDate(timeIntervalSinceNow: interval)
        let dateString = formatDate(date)
        
        cell.detailTextLabel?.text = dateString
        
    }
    
    func populateImage(imageString: String, cell: UITableViewCell) {
        
        let decodedData = NSData(base64EncodedString: imageString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        
        let decodedImage = UIImage(data: decodedData!)
        
        cell.imageView?.image = decodedImage
    }
    
    func tableViewStyle(cell: UITableViewCell) {
        
        cell.contentView.backgroundColor = backgroundColor
        cell.backgroundColor = backgroundColor
        
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        cell.textLabel?.textColor = textColor
        cell.textLabel?.backgroundColor = backgroundColor
        
        cell.detailTextLabel?.font = UIFont.boldSystemFontOfSize(15)
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        cell.detailTextLabel?.backgroundColor = backgroundColor
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
