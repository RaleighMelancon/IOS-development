//
//  AdventurerCell.swift
//  group6_assignment6
//
//  Created by Hughes, Brady L on 3/12/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AdventurerCell: UITableViewCell {
    
    @IBOutlet weak var adventurerImage: UIImageView!
    @IBOutlet weak var adventurerName: UILabel!
    @IBOutlet weak var advLvl: UILabel!
    @IBOutlet weak var advClass: UILabel!
    @IBOutlet weak var advAtk: UILabel!
    @IBOutlet weak var advDef: UILabel!
    @IBOutlet weak var advHp: UILabel!
    @IBOutlet weak var advLs: UILabel!
    @IBAction func deleteCell(_ sender: UIButton) {
        print("delting")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Adventurer")
        userFetch.predicate = NSPredicate(format: "name = %@", adventurerName.text!)
        let users = try! managedContext.fetch(userFetch)
        
        let john: Adventurer = users.first as! Adventurer
        print(john)
        managedContext.delete(john)
        
        do {
            try managedContext.save()
        }
        catch {
            print ("Error: Not saved")
        }

    }
    var adventurerlist = [Adventurer]() 
    func deletedata(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let name = adventurerName.text!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Adventurers")
        fetchRequest.predicate = NSPredicate(format: "username = %@", name)
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
            }
            catch{
                print(error)
            }
            
        }
        catch{
            print(error)
        }
    }
    func play(){
        print(adventurerName.text)
    }
    
    // MARK: Properties
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
