//
//  MasterViewController.swift
//  AigensIOSPlayground
//
//  Created by Peter Liu on 22/9/2016.
//  Copyright © 2016 Aigens. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }*/
        
        observePush()
    }

    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        debugPrint("segue", segue.identifier);
        
        
        if segue.identifier == "Ajax" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cell = self.tableView.cellForRow(at: indexPath)
                let controller = segue.destination as! AjaxViewController
                controller.method = (cell?.reuseIdentifier)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if segue.identifier == "Image" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cell = self.tableView.cellForRow(at: indexPath)
                let controller = segue.destination as! ImageViewController
                controller.method = (cell?.reuseIdentifier)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }else if segue.identifier == "Push" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cell = self.tableView.cellForRow(at: indexPath)
                let controller = segue.destination as! PushViewController
                controller.method = (cell?.reuseIdentifier)!
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

     */

 
    override func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath){
        
        debugPrint("You selected cell #\(indexPath.row)!")
        
        if(indexPath.section == 0){
            self.performSegue(withIdentifier:"Ajax", sender: self)
        }else if(indexPath.section == 1){
            self.performSegue(withIdentifier:"Image", sender: self)
        }else if(indexPath.section == 2){
            self.performSegue(withIdentifier:"Push", sender: self)
        }
    }
    
    
    func observePush(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePush), name: .pushHandler, object: nil)
        
    }
    
    func handlePush(n: NSNotification){
        
        debugPrint("handling push!!", n.userInfo!["message"])
   
        let aps = n.userInfo!["aps"] as! NSDictionary
        let al = aps["alert"] as! NSDictionary
        let title = al["title"] as! String
        let body = al["body"] as! String
        
        
        let alert = UIAlertController(title: title, message: body, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            debugPrint("Handle Ok logic here")
            
            let message = n.userInfo!["message"] as! String
            let json = try? JSONSerialization.jsonObject(with: message.data(using: .utf8)!)
            
            debugPrint("data", json)
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            //print("Handle Cancel Logic here")
        }))
        
        present(alert, animated: true, completion: nil)
 
    }
    
    
}

