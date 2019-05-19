//
//  MenuViewController.swift
//  Moneyball
//
//  Created by Raleigh Melancon on 5/9/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var income: UITextField!
    @IBAction func saveButton(_ sender: UIButton) {
        // Check if input is valid for adding user information
        if (firstName.text?.isEmpty)!{
            self.errorLabel.text = "First Name Empty"
            return
        } else if (lastName.text?.isEmpty)!{
            self.errorLabel.text = "Last Name Empty"
            return
        } else if !(Double(income.text!) != nil){
            self.errorLabel.text = "Income Not Numeric"
            return
        }
        
        self.errorLabel.text = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        print ("made context")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        let entity = NSEntityDescription.entity(forEntityName: "Register", in: managedContext)!
        let saveInfo = NSManagedObject(entity: entity, insertInto: managedContext)
        print ("made entity and saveInfo")
        saveInfo.setValue(firstName.text!, forKeyPath: "firstName")
        saveInfo.setValue(lastName.text!, forKeyPath: "lastName")
        saveInfo.setValue(Float(income.text!), forKeyPath: "income")
        print (entity)
        do {
            print ("tried to save")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("User information saved")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

