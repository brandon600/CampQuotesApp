//
//  QuotePopupVC.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 4/6/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit

class QuotePopupVC: UIViewController {
    
    @IBOutlet weak var quoteText: UILabel!
    
    
    @IBOutlet weak var quoteAuthor: UILabel!
    
    var shareText = ""
    
    var quote = ""
    
    var name = ""
    
    
    private var _likedQuoteCell: QuoteClass!
    var likedQuoteCell: QuoteClass {
        get {
            return _likedQuoteCell
        } set {
            _likedQuoteCell = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quoteText.text = likedQuoteCell.quote
        quoteAuthor.text = likedQuoteCell.name
        shareText = "'\(quoteText.text!) - \(quoteAuthor.text!) Get a quote daily. Find the CAMP Quotes App on the Apple App Store.'"
        print(shareText)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }
    
    
    
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    


}
