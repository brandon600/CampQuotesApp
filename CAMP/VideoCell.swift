//
//  VideoCell.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 6/30/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell  {
    
    var tapped: ((VideoCell) -> Void)?
    
    @IBOutlet weak var videoURL: UIWebView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var shareLbl: UIButton!
    
    var videoShareURL = ""
    
    var shareVidText = ""
    
    var shareCellText = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI(video: Video) {
        videoURL.loadHTMLString(video.embedLink, baseURL: nil)
        
        titleLbl.text = video.title
        nameLbl.text = video.person
        videoShareURL = video.link
        shareVidText = "Checkout this video: \(videoShareURL) -Get the CAMP Quotes App from the Apple App Store for more videos like these."
        
        shareCellText = "Hello."

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    

}
