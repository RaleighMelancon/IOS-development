//
//  StocksViewController.swift
//  Moneyball
//
//  Created by Wang, Frank on 4/25/19.
//  Copyright © 2019 Hughes, Brady L. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
   
    @IBOutlet weak var stockTickerSearchText: UITextField!
    @IBOutlet weak var stockTickerLabel: UILabel!
    @IBOutlet weak var stockPriceLabel: UILabel!
    @IBOutlet weak var stockPercentChangeLabel: UILabel!
    @IBOutlet weak var stockOpen: UILabel!
    @IBOutlet weak var stockDayLowLabel: UILabel!
    @IBOutlet weak var stockDayHighLabel: UILabel!
    @IBOutlet weak var stockVolumeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stockSearch(_ sender: Any) {
        if (stockTickerSearchText.text?.isEmpty)!{
            self.errorLabel.text = "Stock Ticker Empty"
            return
        }
        
        
        // This code is based off the networking tutorial assignmnet https://learnappmaking.com/urlsession-swift-networking-how-to/
        
        let urlBase = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&apikey=04E0N0W7LJT7K8OU&symbol="
        let urlAPI = urlBase + stockTickerSearchText.text!
      
        //print(urlAPI)
        let session = URLSession.shared
        let url = URL(string: urlAPI)!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
                
                // ERROR Check
                
                if json.keys.contains("Error Message") {
                    // contains error key
               
                        DispatchQueue.main.async(execute: {
                           self.errorLabel.text = "Invalid Stock Ticker"
                        })
                    return
                   
                }
                
                let metaData = json["Meta Data"] as? [String: AnyObject]
                let timeSeriesData = json["Time Series (Daily)"] as? [String: AnyObject]
                let timeStamp = metaData!["3. Last Refreshed"] as! String
                let timeStampArray = timeStamp.components(separatedBy: " ")
                let date: String = timeStampArray[0]
                let time: String = timeStampArray[1]
                let timeSeriesCurrentDay = timeSeriesData![date] as! NSDictionary
                
                
                let openPrice = Double(timeSeriesCurrentDay["1. open"] as! String)
                let highPrice = timeSeriesCurrentDay["2. high"] as! String
                let lowPrice = timeSeriesCurrentDay["3. low"] as! String
                let closePrice = Double(timeSeriesCurrentDay["4. close"] as! String)
                let volume = timeSeriesCurrentDay["5. volume"] as! String
                let percentChange = ((closePrice! - openPrice!)/openPrice!)*100
                let percentChangeTrunc = Double(floor(1000*percentChange)/1000)
    
                //print("Done Getting Data")
         
                // Update the labels
                DispatchQueue.main.async(execute: {
                    self.errorLabel.text = ""
                    self.stockTickerLabel.text = self.stockTickerSearchText.text
                    self.timeLabel.text = "Time: " + time
                    self.stockPriceLabel.text = "$\(closePrice!)"
                    self.stockPercentChangeLabel.text = "\(percentChangeTrunc)%"
                    self.stockOpen.text = "$\(openPrice!)"
                    self.stockDayLowLabel.text = "$" + lowPrice
                    self.stockDayHighLabel.text = "$" + highPrice
                    self.stockVolumeLabel.text = volume
                })
                //print("Done Updating Labels")

            }catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
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
