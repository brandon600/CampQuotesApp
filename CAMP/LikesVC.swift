//
//  LikesVC.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 3/20/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit

class LikesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var likedQuoteCells = [QuoteClass]()
    
    var dailyDelivered2 = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
//        self.tableView?.rowHeight = 200.0
        
        
        
        print(likedQuoteCells.count)
        print(dailyDelivered2)
        
        
        if let data2 = UserDefaults.standard.data(forKey: "favoriteQuotes"),
            var myArrayList2 = NSKeyedUnarchiver.unarchiveObject(with: data2) as? [QuoteClass] {
            likedQuoteCells = myArrayList2
        } else {
            print("There was an issue")
        }

    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as? quoteCell {
            
            let quoteCells = likedQuoteCells[indexPath.row]
            
            
            cell.updateUI(likedQuote: quoteCells)
            
            return cell
            
        } else {
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likedQuoteCells.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedQuote = likedQuoteCells[indexPath.row]
        
        performSegue(withIdentifier: "goToLikedPopup", sender: selectedQuote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLikedPopup" {
        if let destination = segue.destination as? QuotePopupVC {
            if let quote = sender as? QuoteClass {
                destination.likedQuoteCell = quote
            }
        }
            
        } else if segue.identifier == "backToVC" {
     //       if let destination = segue.destination as? ViewController {
      //      destination.dailyDelivered = dailyDelivered2
  //              destination.btnAppear()
            print("ha")
        } else {
            print("Data did not pass through correctly")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
             performSegue(withIdentifier: "backToVC", sender: self)
    }
    
    
    
    
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      if let destination = segue.destination as? QuotePopupVC {
 //           if let quote = sender as? QuoteClass {
 //               destination.likedQuoteCell = quote
//        }
//    }
    
    
}
