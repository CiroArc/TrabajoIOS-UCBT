//
//  TableViewController.swift
//  TourWishlist
//
//  Created by USUARIO on 11/14/15.
//  Copyright © 2015 ciroSoft. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController {
    
    @IBAction func homemap(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    var myList:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewDidAppear(animated: Bool) {
        print("Load....")
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDel.managedObjectContext
        let freq = NSFetchRequest (entityName: "MiSites")
        
        myList = try! context.executeFetchRequest(freq)
        //print("Load....")
        tableView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // print("Variable..")
        if (segue.identifier == "update")
        {   print("NEXT...")
            let seletedIndex = self.tableView.indexPathForSelectedRow?.row
            let selectedItem: NSManagedObject = myList[seletedIndex!] as! NSManagedObject
            let desti = segue.destinationViewController as! ItemNewSite
            desti.currentItem = selectedItem
        }
    }
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID: NSString = "Cell"

        //var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as UITableViewCell!
         let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MiTableCell
        
        
        var data:NSManagedObject = myList[indexPath.row] as! NSManagedObject
        cell.LNombre.text = data.valueForKey("nombre") as? String
        cell.LDescripcion.text = data.valueForKey("descripcion") as? String
        //cell.textLabel?.text = data.valueForKey("nombre") as? String
        
        return cell
    }
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let contxt:NSManagedObjectContext = appDel.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            var deletedItem:NSManagedObject = myList[indexPath.row] as! NSManagedObject
            contxt.deleteObject(deletedItem)
            myList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
        }
        
        do {
            try contxt.save()
        } catch _ {
        };
    }




}

