//
//  QuestViewController.swift
//  group6_assignment6
//
//  Created by Hughes, Brady L on 3/12/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class QuestViewController: UIViewController {
    @IBOutlet weak var playerportrait: UIImageView!
    @IBOutlet weak var playername: UILabel!
    @IBOutlet weak var playerlvl: UILabel!
    @IBOutlet weak var playerclass: UILabel!
    @IBOutlet weak var questatk: UILabel!
    @IBOutlet weak var questdef: UILabel!
    @IBOutlet weak var questhp: UILabel!
    @IBOutlet weak var questls: UILabel!
    @IBOutlet weak var questlog: UITextView!

    var name = "Sammy"
    //MARK: NS Data Fetch
    func getdata(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Adventurer")
        userFetch.predicate = NSPredicate(format: "name = %@", name)
        let users = try! managedContext.fetch(userFetch)
        let current: Adventurer = users.first as! Adventurer
        playername.text = current.name
        questhp.text = String(Int(current.totalhitpoints))
        questdef.text = String(Int(current.defense))
        questatk.text = String(Int(current.attackmodifier))
        questls.text = String(Int(current.lifesteal))
        playerclass.text = current.profession
        playerlvl.text = String(Int(current.level))
        playerportrait.image = UIImage(named: current.portrait!)
        
    }
    func savelevel(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Adventurer")
        userFetch.predicate = NSPredicate(format: "name = %@", name)
        let users = try! managedContext.fetch(userFetch)
        let selected: Adventurer = users.first as! Adventurer
        selected.setValue(Int(exp/100), forKey: "level")
    }
    //MARK:Player and enemy stats

    let pclass = "Mage"
    var exp = 100
    let maxhp = 55
    var playeratk: Int = 4
    var playerdef: Int = 4
    var playerhp: Int = 55
    var playerls: Int = 3
    var enemyatk: Int = 3
    var enemydef: Int = 3
    var enemyhp: Int = 0
    
    var playertimer = Timer()
    var enemytimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        playername.text = name
        playertimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(playeraction), userInfo: nil, repeats: true)
        enemytimer = Timer.scheduledTimer(timeInterval: 1.53, target: self, selector: #selector(enemyaction), userInfo: self, repeats: true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        enemytimer.invalidate()
        playertimer.invalidate()
    }
    @objc func playeraction(){
        if (enemyhp <= 0){
            questlog.text = name + " awaits an Enemy"
        }
        else{
            var playerdam = Int(1 + arc4random_uniform(10))
            playerdam = playerdam*playeratk/enemydef
            if (playerdam >= enemyhp){
                enemyhp = 0
                questlog.text = questlog.text + "\n" + name + " did " + String(playerdam) + " damage and defeated Enemy"
                exp += 100
                if ((playerhp + playerls) > maxhp){
                    questlog.text = questlog.text + "\n" + name + " healed for " + String(maxhp - playerhp)
                    playerhp = maxhp
                }
                else{
                    questlog.text = questlog.text + "\n" + name + " healed for " + String(playerls)
                    playerhp += playerls
                }
                questhp.text = String(playerhp)
                if (exp%100 == 0){
                    questlog.text = questlog.text + "\n" + name + " leveled up"
                    savelevel()
                }
            }
            else if(playerdam == 0){
                questlog.text = questlog.text + "\n" + name + " missed their attack"
            }
            else{
                enemyhp -= playerdam
                questlog.text = questlog.text + "\n" + name + " did " + String(playerdam) + " damage"
                if ((playerhp + playerls) > maxhp){
                    if ((maxhp - playerhp) == 0){
                        questlog.text = questlog.text + "\n" + name + " is full health and did not heal"
                    }
                    else{
                        questlog.text = questlog.text + "\n" + name + " healed for " + String(maxhp - playerhp)
                        playerhp = maxhp
                    }
                }
                else{
                    questlog.text = questlog.text + "\n" + name + " healed for " + String(playerls)
                    playerhp += playerls
                }
                questhp.text = String(playerhp)
            }
        }
        playerlvl.text = String(Int(exp/100))
    }
    @objc func enemyaction(){
        if (enemyhp == 0){
            enemyatk = Int(1 + arc4random_uniform(5))
            enemyhp = Int(40 + arc4random_uniform(60))
            enemydef = Int(1 + arc4random_uniform(5))
            questlog.text = questlog.text + "\nA new enemy appeared!"
        }
        else{
            var enemydam = Int(1 + arc4random_uniform(10))
            enemydam = enemydam*enemyatk/playerdef
            if (enemydam >= playerhp){
                playerhp = 0
                playertimer.invalidate()
                enemytimer.invalidate()
                questlog.text = questlog.text + "\nEnemy did " + String(enemydam) + " damage and defeated " + name
                questhp.text = String(playerhp)
            }
            else if(enemydam == 0){
                questlog.text = questlog.text + "\nEnemy waited"
            }
            else{
                playerhp = playerhp-enemydam
                questlog.text = questlog.text + "\nEnemy did " + String(enemydam) + " damage"
                questhp.text = String(playerhp)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
