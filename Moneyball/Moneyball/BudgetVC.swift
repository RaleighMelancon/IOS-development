//
//  BudgetVC.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/23/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import CoreData


var rentcount: Float = 0
var entertainmentcount: Float = 0
var utilitiescount: Float = 0
var foodcount: Float = 0
var transportationcount: Float = 0
var weekid: Int = 0
var expenses = [NSManagedObject]()
var expenseList:[Expense] = []
var register = [NSManagedObject]()
class BudgetVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var budgetTable: UITableView!
    @IBOutlet weak var initBudget: UILabel!
    @IBOutlet weak var currentBudget: UILabel!
    @IBAction func endWeek(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        print ("made context")
        let entity = NSEntityDescription.entity(forEntityName: "Week", in: managedContext)!
        let saveInfo = NSManagedObject(entity: entity, insertInto: managedContext)
        print ("made entity and saveInfo")
        let cat = getTopCategory()
        let budget = register[0].value(forKey: "income") as! Float
        let spent = budget - getCurrentAmount()
        saveInfo.setValue(cat, forKey: "topcategory")
        saveInfo.setValue(register[0].value(forKey: "income"), forKey: "budget")
        saveInfo.setValue(spent, forKey: "expense")
        saveInfo.setValue(weekid, forKey: "weekid")
        do {
            print ("tried to save")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("User information saved")
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // get reference to the persistent container
        let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        
        // perform the delete
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
        getExpenses()
        viewDidAppear(true)
    }
    
    func getTopCategory() -> String{
        var food = 0
        var rent = 0
        var utilities = 0
        var transportation = 0
        var entertainment = 0
        
        for x in expenses{
            if (x.value(forKey: "category") as! String == "Food"){
                food = food + 1
            }
            else if (x.value(forKey: "category") as! String == "Rent"){
                rent = rent + 1
            }
            else if (x.value(forKey: "category") as! String == "Utilities"){
                utilities = utilities + 1
            }
            else if (x.value(forKey: "category") as! String == "Transportation"){
                transportation = transportation + 1
            }
            else if (x.value(forKey: "category") as! String == "Entertainment"){
                entertainment = entertainment + 1
            }
            else{
                print ("Error: Did not match category")
            }
        }
        
        if (food > rent && food > utilities && food > transportation && food > entertainment){
            return "Food"
        }
        else if (rent > food && rent > utilities && rent > transportation && rent > entertainment){
            return "Rent"
        }
        else if (transportation > food && transportation > utilities && transportation > rent && transportation > entertainment){
            return "Transportation"
        }
        else if (entertainment > food && entertainment > entertainment && rent > entertainment && entertainment > rent){
            
            return "Entertainment"
        }
        else if (utilities > food && utilities > rent && utilities > transportation && utilities > entertainment){
            return "Utilities"
        }
        else{
            return "None"
        }
    }
    

    func getExpenses() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let manCon = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Expense")
        do {
            expenses = try manCon.fetch(userFetch) as! [Expense]
        } catch let error as NSError{
            print ("could not save. \(error), \(error.userInfo)")
            abort()
        }
        for x in expenses{
            print ("expenses:", x)
        }
        expenseList = []
        
        
        
    }
    
    func getCurrentAmount() -> Float{
        var budget: Float = 0.0
        for x in expenses{
            budget = budget + (x.value(forKey: "amount") as! Float)
        }
        let income = register[0].value(forKey: "income") as! Float
        print ("total spent: ", budget)
        budget = income - budget
        return budget
    }

    func getBudget(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Register")
        do {
            register = try managedContext.fetch(userFetch) as! [Register]
        } catch let error as NSError{
            print ("could not save. \(error), \(error.userInfo)")
            abort()
        }
        print (expenses)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        getExpenses()
        getBudget()
        if (register.count == 0){
            initBudget.text = "$0.00"
            currentBudget.text = "$0.00"
        }
        else{
            var budget = register[0].value(forKey: "income") as! Float
            var current = getCurrentAmount()
            
            
            initBudget.text = "$"+String(format: "%.2f", budget)
            currentBudget.text = "$"+String(format: "%.2f", current)
        }
        
    }
    
    let pieChart = PieChart()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    
    override func viewDidAppear(_ animated: Bool) {
        self.loadView()
        self.viewWillAppear(true)
        foodcount = 0
        utilitiescount = 0
        entertainmentcount = 0
        rentcount = 0
        transportationcount = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return expenses.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellname = "budgetcell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellname, for: indexPath) as! BudgetCell
        
        for x in expenses{
            expenseList.append(x as! Expense)
        }
        print (expenseList)
        
        let expense = expenseList[indexPath.row]
        print (expense.value(forKey: "amount"))
        let amount = expense.value(forKey: "amount") as! Float
        
        
        
        if (expense.value(forKey: "category") as! String == "Food"){
            foodcount += Float(amount)
        }
        else if (expense.value(forKey: "category") as! String == "Utilities"){
            utilitiescount += amount
        }
        else if (expense.value(forKey: "category") as! String == "Transportation"){
            transportationcount += amount
        }
        else if (expense.value(forKey: "category") as! String == "Entertainment"){
            entertainmentcount += amount
        }
        else if (expense.value(forKey: "category") as! String == "Rent"){
            rentcount += amount
        }
        
        cell.expenseName.text = expense.value(forKey: "name") as! String
        cell.category.text = expense.value(forKey: "category") as! String
        cell.cost.text = "$"+String(format: "%.2f", amount)
        

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
