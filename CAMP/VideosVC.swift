//
//  VideosVC.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 6/30/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit

class VideosVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var objects: NSMutableArray! = NSMutableArray()
    
    
    var shareText2 = "Hello this is some text from CAMP."
    
    
    var videoCollection = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")
        self.objects.add("https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        self.objects.add("https://www.youtube.com/watch?v=oSSUM5UdPEc")
        self.objects.add("https://www.youtube.com/watch?v=_ztgMxdXafI")
        self.objects.add("https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        self.objects.add("https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        self.objects.add("https://www.youtube.com/watch?v=CZx4DTglHJc")

        
        let v0 = Video(title: "The Golden Cirlce", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/qp0HIF3SfI4\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=qp0HIF3SfI4&t=1s")
        
        
        let v1 = Video(title: "Secrets of Happiness", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/oSSUM5UdPEc\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=oSSUM5UdPEc")
        
        
        let v2 = Video(title: "Inspiring Speech", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/_ztgMxdXafI\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=_ztgMxdXafI")
        
        let v3 = Video(title: "Motivational Rocky Scene", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/D_Vg4uyYwEk\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Rocky", link: "https://www.youtube.com/watch?v=D_Vg4uyYwEk")
        
        let v4 = Video(title: "How To Wake Up Determined", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/0ITwLbl4MKQ\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=0ITwLbl4MKQ")
        
        let v5 = Video(title: "5 Ideas That Could Change Your Life", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/CZx4DTglHJc\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=CZx4DTglHJc")
        
        let v6 = Video(title: "Self-Motivation Secret", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/2Lz0VOltZKA\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Mel Robbins", link: "https://www.youtube.com/watch?v=2Lz0VOltZKA")
        
        
        let v7 = Video(title: "Why You Don't Succeed", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/3ev7GXzFTPg\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=3ev7GXzFTPg")
  
        let v8 = Video(title: "Start With Why", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/u4ZoJKF_VuA\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=u4ZoJKF_VuA")
        
        let v9 = Video(title: "Find Your True Purpose", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/WBR29z50O-k\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=WBR29z50O-k")
        
        let v10 = Video(title: "What's Your Why", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/RX4BzOneGmI\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Eric Thomas", link: "https://www.youtube.com/watch?v=RX4BzOneGmI")
        
        let v11 = Video(title: "How Bad Do You Want It", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/6vuetQSwFW8\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Eric Thomas", link: "https://www.youtube.com/watch?v=6vuetQSwFW8")
        
        let v12 = Video(title: "Why The 1% Succeed", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/TuKlCOn8uFY\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Eric Thomas", link: "https://www.youtube.com/watch?v=TuKlCOn8uFY")
        
        let v13 = Video(title: "You Owe You", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/7Oxz060iedY\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Eric Thomas", link: "https://www.youtube.com/watch?v=7Oxz060iedY")
        
        let v14 = Video(title: "I Can, I Will, I Must", embedLink: "<iframe width=\"270\" height=\"140\" src=\"ttps://www.youtube.com/embed/L8UT0iVne24\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Multiple Speakers", link: "https://www.youtube.com/watch?v=L8UT0iVne24")
        
        let v15 = Video(title: "Motivational Speech 2018", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/sD5AjfZQYqY\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Denzel Washington", link: "https://www.youtube.com/watch?v=sD5AjfZQYqY")
        
        let v16 = Video(title: "How Bad Do You Want Success", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/lsSC2vx7zFQ\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Eric Thomas", link: "https://www.youtube.com/watch?v=lsSC2vx7zFQ")
        
        let v17 = Video(title: "Millienials In The Workplace", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/hER0Qp6QJNU\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=hER0Qp6QJNU&feature=youtu.be")
        
        let v18 = Video(title: "Why Leaders Eat Last", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/ReRcHdeUG9Y\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=ReRcHdeUG9Y")
        
        let v19 = Video(title: "If You Don't Understand People, You Don't Understand Business", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/llKvV8_T95M\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=llKvV8_T95M")
        
        let v20 = Video(title: "Know The Game Your In", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/RyTQ5-SQYTo\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=RyTQ5-SQYTo")
        
         let v21 = Video(title: "Things I Wish I Knew When I Was Younger", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/p9gzGmyDJvc\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=p9gzGmyDJvc")
        
        let v22 = Video(title: "What Game Theory Teaches Us About War", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/0bFs6ZiynSU\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=0bFs6ZiynSU")
        
        let v23 = Video(title: "How To Be a Great Leader", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/NzBqJNh8z2U\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Simon Sinek", link: "https://www.youtube.com/watch?v=NzBqJNh8z2U")
        
        let v24 = Video(title: "The People Vs. The School System", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/dqTTojTija8\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Prine Ea", link: "https://www.youtube.com/watch?v=dqTTojTija8")
        
        let v25 = Video(title: "Any Given Sunday", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/oSDhhZtRwFU\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Al Pacino", link: "https://www.youtube.com/watch?v=oSDhhZtRwFU")
        
        let v26 = Video(title: "Give Up Mr. Cuz", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/6p3GaCwvUoE\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Coach Carter", link: "https://www.youtube.com/watch?v=6p3GaCwvUoE")
        
        let v27 = Video(title: "What's A Matter You Wimps", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/Zp2VQ4SIRWM\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Coach", link: "https://www.youtube.com/watch?v=Zp2VQ4SIRWM")
        
        let v28 = Video(title: "The Replacements Ending", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/pbZTXm-Oot0\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Mutiple Acts", link: "https://www.youtube.com/watch?v=pbZTXm-Oot0")
        
        let v29 = Video(title: "We Are Marshall - Pre Game Speech", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/IEL8PYu4RR4\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Matthew McConaughey", link: "https://www.youtube.com/watch?v=IEL8PYu4RR4")
        
        let v30 = Video(title: "Miracle Speech - You Were Born For This", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/tdmyoMe4iHM\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Herb Brooks", link: "https://www.youtube.com/watch?v=tdmyoMe4iHM")
        
        let v31 = Video(title: "Motivation From The Movies", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/MYKsbld6LII\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Multiple Acts", link: "https://www.youtube.com/watch?v=MYKsbld6LII")
        
        let v32 = Video(title: "Death Crawl Scene - Facing The Giants", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/-sUKoKQlEC4\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Grant Taylor", link: "https://www.youtube.com/watch?v=-sUKoKQlEC4")
        
        let v33 = Video(title: "Stand Out", embedLink: "<iframe width=\"270\" height=\"140\" src=\"https://www.youtube.com/embed/w8UMOwq4i3A\" frameborder=\"0\" allow=\"autoplay; encrypted-media\" allowfullscreen></iframe>", person: "Multiple Speakers", link: "https://www.youtube.com/watch?v=w8UMOwq4i3A")
        
        
        videoCollection.append(v0)
        videoCollection.append(v1)
        videoCollection.append(v2)
        videoCollection.append(v3)
        videoCollection.append(v4)
        videoCollection.append(v5)
        videoCollection.append(v6)
        videoCollection.append(v7)
        videoCollection.append(v8)
        videoCollection.append(v9)
        videoCollection.append(v10)
        videoCollection.append(v11)
        videoCollection.append(v12)
        videoCollection.append(v13)
        videoCollection.append(v14)
        videoCollection.append(v15)
        videoCollection.append(v16)
        videoCollection.append(v17)
        videoCollection.append(v18)
        videoCollection.append(v19)
        videoCollection.append(v20)
        videoCollection.append(v21)
        videoCollection.append(v22)
        videoCollection.append(v23)
        videoCollection.append(v24)
        videoCollection.append(v25)
        videoCollection.append(v26)
        videoCollection.append(v27)
        videoCollection.append(v28)
        videoCollection.append(v29)
        videoCollection.append(v30)
        videoCollection.append(v31)
        videoCollection.append(v32)
        videoCollection.append(v33)

    
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
   
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell {
            
            cell.tapped = { [unowned self] (selectedCell) -> Void in
                let path = tableView.indexPathForRow(at: selectedCell.center)!
                let selectedItem = self.videoCollection[path.row]
                
                print("the selected item is \(selectedItem)")
            }
            
            let thisVideo = videoCollection[indexPath.row]
            
            cell.updateUI(video: thisVideo)
            
            cell.shareCellText = objects.object(at: indexPath.row) as! String
            
            cell.shareLbl.tag = indexPath.row
            
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let thisVideo = videoCollection[indexPath.row]
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoCollection.count
    }
    
    
    
    @IBAction func shareVidPressed(_ sender: Any) {
        
        let titleString = self.objects.object(at: (sender as AnyObject).tag) as? String
        
        let titleStringURL = NSURL(string: titleString!)
        
        shareText2 = "Checkout this video: \(titleStringURL!) -Get the CAMP App from the Apple App Store for more videos like these."
        
        let activityController = UIActivityViewController(activityItems: [shareText2], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
     

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
