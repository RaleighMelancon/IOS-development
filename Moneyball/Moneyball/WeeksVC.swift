//
//  WeeksVC.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/25/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import CoreData

var weeks = [NSManagedObject]()
class WeeksVC: UITableViewController {
    @IBAction func clearWeeks(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Are you sure you want to erase all weeks?", message: "This will permanently delete all past records.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Week")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            // get reference to the persistent container
            let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
            
            // perform the delete
            do {
                try persistentContainer.viewContext.execute(deleteRequest)
            } catch let error as NSError {
                print(error)
            }
            self.viewDidAppear(true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Week")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        // get reference to the persistent container
//        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//
//        // perform the delete
//        do {
//            try persistentContainer.viewContext.execute(deleteRequest)
//        } catch let error as NSError {
//            print(error)
//        }
//        viewDidAppear(true)
    }
    
    func getWeeks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Week")
        do {
            weeks = try managedContext.fetch(userFetch) as! [Week]
        } catch let error as NSError{
            print ("could not save. \(error), \(error.userInfo)")
            abort()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getWeeks()
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Week")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//        // get reference to the persistent container
//        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//
//        // perform the delete
//        do {
//            try persistentContainer.viewContext.execute(deleteRequest)
//        } catch let error as NSError {
//            print(error)
//        }
//        viewDidAppear(true)
        print (weeks)
        print ("Got to Weeks page")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        getWeeks()
        self.tableView.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadView()
        self.viewWillAppear(true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellname = "weekcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellname, for: indexPath) as! WeekCell
        
        let week = weeks[indexPath.row]
        
        let flspent = week.value(forKey: "expense") as! Float
        let flbudget = week.value(forKey: "budget") as! Float
        let intid = week.value(forKey: "weekid") as! Int
        cell.category.text = week.value(forKey: "topcategory") as! String
        cell.budget.text = String(format: "%.2f", flbudget)
        cell.spent.text = String(format: "%.2f", flspent)
        cell.weekid.text = String(intid)
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
