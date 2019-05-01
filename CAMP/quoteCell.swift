//
//  quoteCell.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 3/20/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit

class quoteCell: UITableViewCell {
    
    
    @IBOutlet weak var quoteText: UILabel!
    
    
    @IBOutlet weak var nameText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI(likedQuote: QuoteClass) {
        quoteText.text = likedQuote.quote
        nameText.text = likedQuote.name
        print(likedQuote.quote)
        print(likedQuote.name)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
