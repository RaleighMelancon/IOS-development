//
//  AddViewController.swift
//  group6_assignment6
//
//  Created by Hughes, Brady L on 3/12/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddViewController: UIViewController{
    
    
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var magebutton: UIButton!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var AdventurerClass: UITextField!
    @IBOutlet weak var facebutton: UIButton!
    @IBOutlet weak var roguebutton: UIButton!
    @IBOutlet weak var warriorbutton: UIButton!
    @IBAction func Cancel(_ sender: UIButton) {
        Name.text = ""
        AdventurerClass.text = ""
        portrait = ""
    }
    @IBAction func mage(_ sender: UIButton) {
        portrait = "mage.jpg"
        if (magebutton.isSelected){
            magebutton.setImage(UIImage(named: "mage.jpg"), for: .normal)
            magebutton.isSelected = false
        }
        else{
            magebutton.setImage(UIImage(named: "mage-highlighted.jpg"), for: .selected)
            magebutton.isSelected = true
            roguebutton.isSelected = false
            warriorbutton.isSelected = false
            facebutton.isSelected = false
        }
    }
    @IBAction func face(_ sender: UIButton) {
        portrait = "face.jpg"
        if (facebutton.isSelected){
            facebutton.setImage(UIImage(named: "face.jpg"), for: .normal)
            facebutton.isSelected = false
        }
        else{
            facebutton.setImage(UIImage(named: "face-highlighted.jpg"), for: .selected)
            facebutton.isSelected = true
            roguebutton.isSelected = false
            warriorbutton.isSelected = false
            magebutton.isSelected = false
        }
    }
    @IBAction func rogue(_ sender: UIButton) {
        portrait = "rogue.jpg"
        if (roguebutton.isSelected){
            roguebutton.setImage(UIImage(named: "rogue.jpg"), for: .normal)
            roguebutton.isSelected = false
        }
        else{
            roguebutton.setImage(UIImage(named: "rogue-highlighted.jpg"), for: .selected)
            roguebutton.isSelected = true
            magebutton.isSelected = false
            warriorbutton.isSelected = false
            facebutton.isSelected = false
        }
    }
    @IBAction func warrior(_ sender: UIButton) {
        portrait = "warrior.jpg"
        if (warriorbutton.isSelected){
            warriorbutton.setImage(UIImage(named: "warrior.jpg"), for: .normal)
            warriorbutton.isSelected = false
        }
        else{
            warriorbutton.setImage(UIImage(named: "warrior-highlighted.jpg"), for: .selected)
            warriorbutton.isSelected = true
            roguebutton.isSelected = false
            magebutton.isSelected = false
            facebutton.isSelected = false
        }
        
    }
    var portrait: String = ""
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

    
    @IBAction func AddAdventurer(_ sender: UIButton) {
        // Code adopted and modified from https://medium.com/kkempin/coredata-basics-xcode-9-swift-4-56a0fc1d40cb
        if !((Name.text?.isEmpty)! || (AdventurerClass.text?.isEmpty)! || (portrait == "")) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let adventurerEntity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)!
            let adventurer = NSManagedObject(entity: adventurerEntity, insertInto: managedContext)
            
            adventurer.setValue(Name.text!, forKeyPath: "name")
            adventurer.setValue(AdventurerClass.text!, forKeyPath: "profession")
            adventurer.setValue(Int(arc4random_uniform(5)+1), forKeyPath: "attackmodifier")
            adventurer.setValue(Int(arc4random_uniform(5)+1), forKeyPath: "defense")
            adventurer.setValue(1, forKeyPath: "level")
            adventurer.setValue(Int(arc4random_uniform(5)+1), forKeyPath: "lifesteal")
            adventurer.setValue(portrait, forKeyPath: "portrait")
            adventurer.setValue(Int(arc4random_uniform(21)+40), forKeyPath: "totalhitpoints")
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            print("Data Saved")
            
            
            
            
            
            
            
            
        }
        else{
            errorlabel.text = "User must enter name, class and select an image"
        }
        
    }
    
    
}

