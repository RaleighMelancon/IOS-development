//
//  AddExpenseVC.swift
//  Moneyball
//
//  Created by Hughes, Brady L on 4/23/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit
import CoreData

class AddExpenseVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerValue = ""
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerValue = pickerData[row]
    }
    
    
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var category: UIPickerView!
    @IBAction func add(_ sender: UIButton) {
        // Check if input is valid for adding expenses
        if (name.text?.isEmpty)!{
            self.errorLabel.text = "Expense Name Empty"
            return
        } else if (amount.text?.isEmpty)!{
            self.errorLabel.text = "Amount is Empty"
            return
        } else if !(Double(amount.text!) != nil){
            self.errorLabel.text = "Amount Not Numeric"
            return
        } else if (pickerValue == ""){
            self.errorLabel.text = "Select Category"
            return
        }
        self.errorLabel.text = ""
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        print ("made context")
        let entity = NSEntityDescription.entity(forEntityName: "Expense", in: managedContext)!
        let expense = NSManagedObject(entity: entity, insertInto: managedContext)
        print ("made entity and saveInfo")
        
        let amountFloat = Float(amount.text!)!
        print (amountFloat)
        
        expense.setValue(name.text!, forKey: "name")
        print ("name field text: " + name.text!)
        expense.setValue(amountFloat, forKey: "amount")
        print ("amount field text: " + amount.text!)
        expense.setValue(pickerValue, forKey: "category")
        
        print("entity amount as string: ", expense.value(forKey: "amount"))

        print (entity)
        do {
            print ("tried to save")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("User information saved")
        print(expense)
    }
    
    var pickerData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.category.delegate = self
        self.category.dataSource = self
        
        pickerData = ["Food", "Entertainment", "Rent", "Utilities", "Transportation"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
