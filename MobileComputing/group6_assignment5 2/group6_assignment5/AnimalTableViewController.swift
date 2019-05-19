//
//  AnimalTableViewController.swift
//  group6_assignment5
//
//  Created by Hughes, Brady L on 2/28/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import Foundation

class AnimalImage{
    var image:UIImage
    var caption:String = ""
    
    init(image:UIImage, caption:String){
        self.image = image
        self.caption = caption
    }
}

class Animal{
    var name:String = "Error"
    var sciname:String = "Error"
    var aclass:String = "Error"
    var size:String = "Error"
    var album:[AnimalImage] = []
    var thumbnail: UIImage? = nil
    
    init(name: String, sciname: String, aclass: String, size: String, album: [AnimalImage]){
        self.name = name
        self.sciname = sciname
        self.aclass = aclass
        self.size = size
        self.album = album
        self.thumbnail = self.album[0].image
    }
}

class AnimalTableViewController: UITableViewController {
    
    var animals = [Animal]() //this stores the animal objects and allows for variable table length and number of fields
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("Table View Did Load")
        //collection_of_Animals()
        accessAnimalPlist()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    func accessAnimalPlist(){
        // Based off in class code
        let inputFile = Bundle.main.path(forResource: "Animal", ofType: "plist")
        let inputDataArray = NSArray(contentsOfFile: inputFile!)
        
        for input in (inputDataArray as? [Dictionary<String, String>])! {
            
            
            
            
            let animalImage1 = AnimalImage(image:UIImage(named: input["imagename1"]!)! , caption: input["imagename1caption"]!)
            
            let animalImage2 = AnimalImage(image:UIImage(named: input["imagename2"]!)! , caption: input["imagename2caption"]!)
            let animalImage3 = AnimalImage(image:UIImage(named: input["imagename3"]!)! , caption: input["imagename3caption"]!)
            
            
            let animal = Animal(name: input["name"]!, sciname: input["sciname"]! , aclass: input["aclass"]!, size: input["size"]!, album: [animalImage1,animalImage2, animalImage3])
            animals += [animal]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return animals.count*2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index:Int = indexPath.row/2
        
        
        //Allows for the same animal object to be referenced twice
        
        let animal = animals[index]
        
        let cellIdentifier1 = "AnimalTableViewCell"
        let cellIdentifier2 = "Animal2TableViewCell"
        
        //Displays for the rows
        if(indexPath.row % 2 == 0) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier1, for: indexPath as IndexPath) as! AnimalTableViewCell
            
            cell.commonAnimalNameLabel.text = animal.name
            cell.animalImageView.image = animal.thumbnail
            
            
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath as IndexPath) as! Animal2TableViewCell
            
            cell.scinameLabel.text = animal.sciname
            cell.aclassLabel.text = animal.aclass
            cell.sizeLabel.text = animal.size
            return cell
        }
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is animalCollectionViewController2){
            var collect = segue.destination as? animalCollectionViewController2
            collect!.animalList = animals
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
