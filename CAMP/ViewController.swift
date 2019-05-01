//
//  ViewController.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 2/27/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var logoBtnView: UIView!
    
    @IBOutlet weak var helloLbl: UILabel!
    
    @IBOutlet weak var tapBtnLbl: UILabel!
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var goodByeLbl: UILabel!
    
    @IBOutlet weak var campLogoBtn: UIButton!
    
    @IBOutlet weak var xIcon: UIButton!
    
    @IBOutlet weak var heartIcon: UIButton!
    
    
    @IBOutlet weak var likesBtn: UIButton!
    
    
    @IBOutlet weak var myLikesBtnLbl: UILabel!
    
    
    
    var quoteNumber = Int()
    
    
    var quoteCells = [QuoteClass]()
    
    var quoteCellsB = [QuoteClass]()
    
    
    var favoriteQuotes = [QuoteClass]()
    
    var quoteKey = Int()
    
    var hasClicked = false
    
    var dailyDelivered = false
    
    var savedDate = ""
    
    var dateResultCheck = ""
    
    var todayQuoteText = ""
    
    var todayQuoteAuthor = ""
    
    var removeQuote = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        setupNotifications()
        
        viewSetup()
        
        getDate()
        
        if let data = UserDefaults.standard.data(forKey: "quoteCells"),
            let myArrayList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [QuoteClass] {
            quoteCells = myArrayList
        } else {
            print("There was an issue")
        }
        
        if let data2 = UserDefaults.standard.data(forKey: "favoriteQuotes"),
            var myArrayList2 = NSKeyedUnarchiver.unarchiveObject(with: data2) as? [QuoteClass] {
            favoriteQuotes = myArrayList2
        } else {
            print("There was an issue")
        }
        
        
        if let dataB = UserDefaults.standard.data(forKey: "quoteCellsB"),
            let myArrayListB = NSKeyedUnarchiver.unarchiveObject(with: dataB) as? [QuoteClass] {
            quoteCellsB = myArrayListB
        } else {
            print("There was an issue B")
        }
        
        if let dataDate = UserDefaults.standard.data(forKey: "savedDate"),
            let myDate = NSKeyedUnarchiver.unarchiveObject(with: dataDate) as? String {
            print("We have successfully loaded the saved date which is \(savedDate)")
            savedDate = myDate
        } else {
            print("Big time error homie")
        }
        
        print("The saved date is \(savedDate)")
        print("The datResultCheck is \(dateResultCheck)")
        
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if dailyDelivered == false {
           btnAppear()
        } else {
            print("Error")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewSetup() {
        logoBtnView.isHidden = true
        helloLbl.isHidden = true
        tapBtnLbl.isHidden = true
        quoteLabel.isHidden = true
        goodByeLbl.isHidden = true
        nameLabel.isHidden = true
        xIcon.isHidden = true
        heartIcon.isHidden = true
        likesBtn.isHidden = true
        myLikesBtnLbl.isHidden = true
    }
    


    func btnAppear() {
        logoBtnView.isHidden = false
        UIView.animate(withDuration: 2.2, animations: {
            self.logoBtnView.frame = CGRect(x: 0, y: self.view.center.x - 30, width: 375, height: 320)
        }) { (finished) in
            self.helloLbl.isHidden = false
            self.tapBtnLbl.isHidden = false
            self.likesBtn.isHidden = false
            self.myLikesBtnLbl.isHidden = false
        }
    }
    
    @IBAction func campLogoBtnPressed(_ sender: Any) {
        if quoteCells.count < 1 {
        appendQuotes();
        logoBtnClicked()
        } else if quoteCells.count > 1 {
            logoBtnClicked()
        }
    }
    
    func logoBtnClicked() {
        if hasClicked == false && savedDate != dateResultCheck {
            let image = UIImage(named: "testImage2")
            campLogoBtn.setImage(image, for: .normal)
            UIView.transition(with: campLogoBtn, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            getRandomQuote()
            
            self.helloLbl.isHidden = true
            self.tapBtnLbl.isHidden = true
            self.xIcon.isHidden = false
            self.heartIcon.isHidden = false
            hasClicked = true
            dailyDelivered = true
            print("True")
            print("\(savedDate) is not equal to \(dateResultCheck)")
            
            self.quoteCells.remove(at: self.quoteKey)
            print(quoteCells.count)
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.quoteCells)
            UserDefaults.standard.set(encodedData, forKey: "quoteCells")
            
            UserDefaults.standard.synchronize()
            
            if let data = UserDefaults.standard.data(forKey: "quoteCells"),
                let myArrayList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [QuoteClass] {
                print("Done successful")
            } else {
                print("There was an issue")
            }
            
            
        } else if hasClicked == false && savedDate == dateResultCheck {
            let image = UIImage(named: "testImage2")
            campLogoBtn.setImage(image, for: .normal)
            UIView.transition(with: campLogoBtn, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
            displayTodayQuote()
            
            
            self.helloLbl.isHidden = true
            self.tapBtnLbl.isHidden = true
            
            hasClicked = true
            dailyDelivered = true
            print("Quote not true")
            print("\(savedDate) is equal to \(dateResultCheck)")
            
        } else if hasClicked == true {
            print("Nothing is happening")
        } else {
            print("Nothing is happening")
        }
    }
    
    func getRandomQuote() {
        var randomItem = Int(arc4random() % UInt32(quoteCells.count))
        
        quoteKey = quoteCells[randomItem].key
        todayQuoteText = "\(quoteCells[randomItem].quote)"
        todayQuoteAuthor = "\(quoteCells[randomItem].name)"
        quoteLabel.text = todayQuoteText
        nameLabel.text = todayQuoteAuthor
        UIView.animate(withDuration: 3.0, animations: {
            self.quoteLabel.isHidden = false
            self.nameLabel.isHidden = false
            self.quoteLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            print(self.quoteCells.count)
        })
        
        savedDate = dateResultCheck
        removeQuote = true
        
        var userDefaults = UserDefaults.standard
        
        let encodedDayQData: Data = NSKeyedArchiver.archivedData(withRootObject: todayQuoteText)
        
        userDefaults.set(encodedDayQData, forKey: "todayQuoteText")
        
        let encodedDayAData: Data = NSKeyedArchiver.archivedData(withRootObject: todayQuoteAuthor)
        
        userDefaults.set(encodedDayAData, forKey: "todayQuoteAuthor")
        
        
        
        let encodedDateData: Data = NSKeyedArchiver.archivedData(withRootObject: savedDate)
        
        
        userDefaults.set(encodedDateData, forKey: "savedDate")
        
        
        
        userDefaults.synchronize()
        
        print("The saved date saves and is \(savedDate)")
        print(removeQuote)
        
        
        
        if let currentQuote = userDefaults.data(forKey: "todayQuoteText"),
            let currentQ = NSKeyedUnarchiver.unarchiveObject(with: currentQuote) as? String {
            print(currentQ)
        } else {
            print("Big time quote error homie")
        }
        
        
        if let dataDate = userDefaults.data(forKey: "savedDate"),
            let myDate = NSKeyedUnarchiver.unarchiveObject(with: dataDate) as? String {
            print("Date result check is \(dateResultCheck)")
            print("Save date in this bih is \(myDate)")
            print("The saved date will be \(savedDate)")
        } else {
            print("Big time error homie")
        }
        
        
    }
    
    func displayTodayQuote() {
        if let dataQT = UserDefaults.standard.data(forKey: "todayQuoteText"),
            let todayQT = NSKeyedUnarchiver.unarchiveObject(with: dataQT) as? String  {
            todayQuoteText = todayQT
            quoteLabel.text = todayQuoteText
        } else {
            print("There was an issue")
        }
        
        if let dataQA = UserDefaults.standard.data(forKey: "todayQuoteAuthor"),
            let todayQA = NSKeyedUnarchiver.unarchiveObject(with: dataQA) as? String  {
            todayQuoteAuthor = todayQA
            nameLabel.text = todayQuoteAuthor
        } else {
            print("There was an issue")
        }
        
        UIView.animate(withDuration: 3.0, animations: {
            self.quoteLabel.isHidden = false
            self.nameLabel.isHidden = false
            self.quoteLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            print(self.quoteCells.count)
        })
        
    }
    
    
    @IBAction func swipeClose(_ sender: UISwipeGestureRecognizer) {
        swipeCloseSwiped { (success) -> Void in
            if success {
                logoGoUp()
            }
        }
    }
    
    func swipeCloseSwiped(completion: (_ success: Bool) -> Void) {
        if hasClicked == true {
            let image = UIImage(named: "campLogo12")
            campLogoBtn.setImage(image, for: .normal)
            UIView.transition(with: campLogoBtn, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            self.quoteLabel.isHidden = true
            self.nameLabel.isHidden = true
            self.xIcon.isHidden = true
            self.heartIcon.isHidden = true
            completion(true)
        }
    }
    
    func logoGoUp() {
        UIView.animate(withDuration: 3.0, animations: {
            self.logoBtnView.frame = CGRect(x: 0, y: -325, width: 375, height: 288)
             self.goodByeLbl.isHidden = false
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.quoteCells)
            UserDefaults.standard.set(encodedData, forKey: "quoteCells")
            
            UserDefaults.standard.synchronize()
            
            if let data = UserDefaults.standard.data(forKey: "quoteCells"),
                let myArrayList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [QuoteClass] {
                print("Done successful")
            } else {
                print("There was an issue")
            }
            
            
        }) { (finished) in
            self.showGoodByeLbl()
        }
    }
    
    func showGoodByeLbl() {
        UIView.animate(withDuration: 2.0, animations: {
            self.goodByeLbl.alpha = 1.0
        })
    }
    
    func setupNotifications() {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("User Notifications Have Been Granted")
            } else {
                print(error?.localizedDescription)
            }
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                print("Notifcations are not allowed")
            } else if settings.authorizationStatus == .authorized {
                print("Notifcations are allowed")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Goodmorning!"
        content.body = "Your daily quote is ready. Click here to view it."
        content.sound = UNNotificationSound.default()
        
        var dateInfo = DateComponents()
        dateInfo.hour = 08
        dateInfo.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
    
    func getDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateResult = formatter.string(from: date)
        dateResultCheck = dateResult
        print("Successfully got current date. The data is \(dateResult)")
    }
    
    func checkDate() {
        
    }
    
    func appendQuotes() {
        var q0 = QuoteClass(key: 0, quote: "Do what you have to do until you can do what you want to do.", name: "Oprah Winfrey", like: 0)
        
        var q1 = QuoteClass(key: 1, quote: "Hustle until your haters ask if you are hiring.", name: "Anonymous", like: 0)
        
        var q2 = QuoteClass(key: 2, quote: "Your time is limited, so don’t waste it living someone else’s life.", name: "Steve Jobs", like: 0)
        
        var q3 = QuoteClass(key: 3, quote: "If you can’t fly, then run. If you can’t run, then walk. If you can’t walk, then crawl, but whatever you do, keep moving forward.", name: "Martin Luther King Jr.", like: 0)
        
        var q4 = QuoteClass(key: 4, quote: "Whatever you are, be a good one.", name: "Abraham Lincoln", like: 0)
        
        var q5 = QuoteClass(key: 5, quote: "All of our dreams can come true, if we have the courage to pursue them.", name: "Walt Disney", like: 0)
        
        var q6 = QuoteClass(key: 6, quote: "Stay away from negative people, they have a problem for every solution.", name: "Albert Einstein", like: 0)
        
        var q7 = QuoteClass(key: 7, quote: "A negative mind will never give you a positive life.", name: "Unknown", like: 0)
        
        var q8 = QuoteClass(key: 8, quote: "Nothing changes until you change. Everything changes once you change.", name: "Anonymous", like: 0)
        
        var q9 = QuoteClass(key: 9, quote: "Anyone who has never made a mistake has never tried anything new.", name: "Albert Einstein", like: 0)
        
        var q10 = QuoteClass(key: 10, quote: "Most people who succeed in the face of seemingly impossible conditions are people who simply don’t know how to quit.", name: "Robert Schuller", like: 0)
        
        var q11 = QuoteClass(key: 11, quote: "The cost of being wrong is less than the cost of doing nothing.", name: "Seth squidoo", like: 0)
        
        var q12 = QuoteClass(key: 12, quote: "Be who you are and say what you feel, because those who mind don’t matter and those who matter don’t mind.", name: "Dr. Seuss", like: 0)
        
        var q13 = QuoteClass(key: 13, quote: "whether you think you can, or you think you can’t, you’re probably right.", name: "Anonymous", like: 0)
        
        var q14 = QuoteClass(key: 14, quote: "A day without laughter is a day wasted.", name: "Charlie Chaplin", like: 0)
        
        var q15 = QuoteClass(key: 15, quote: "A pessimist see the difficulty in every opportunity; an optimist sees the opportunity in every difficulty.", name: "Winston Churchill", like: 0)
        
        var q16 = QuoteClass(key: 16, quote: "Many of life’s failures are people who did not realize how close they were to success when they gave up.", name: "Thomas Edison", like: 0)
        
        var q17 = QuoteClass(key: 17, quote: "Be sure what you are doing today is getting you closer to where you want to be tomorrow.", name: "Anonymous", like: 0)
        
        var q18 = QuoteClass(key: 18, quote: "Look for something positive in each day, even if some days you have to look a little harder.", name: "Anonymous", like: 0)
        
        var q19 = QuoteClass(key: 19, quote: "What your real friends know about you is far more important than what your facebook friends think about you.", name: "Coach Mike", like: 0)
        
        var q20 = QuoteClass(key: 20, quote: "Wherever you go, no matter what the weather, always take your own sunshine.", name: "Anthony J D’angelo", like: 0)
        
        var q21 = QuoteClass(key: 21, quote: "A head full of fears has no space for dreams.", name: "Anonymous", like: 0)
        
        var q22 = QuoteClass(key: 22, quote: "Be somebody who makes everybody feel like somebody.", name: "Anonymous", like: 0)
        
        var q23 = QuoteClass(key: 23, quote: "Once you replace negative thoughts with positive ones, you’ll start having positive results.", name: "Willie Nelson", like: 0)
        
        var q24 = QuoteClass(key: 24, quote: "Always believe in yourself, because if you don’t, then who will?", name: "Marilyn Monroe", like: 0)
        
        var q25 = QuoteClass(key: 25, quote: "Life is not always the party we hoped for but it’s always a good idea to dance.", name: "Anonymous", like: 0)
        
        var q26 = QuoteClass(key: 26, quote: "There may be people that have more talent than you, but there’s no excuse for anyone to work harder than you do.", name: "Derek Jeter", like: 0)
        
        var q27 = QuoteClass(key: 27, quote: "Try never to be the smartest person in the room. And if you are, invite smarter people or find a different room.", name: "Michael Dell", like: 0)
        
        var q28 = QuoteClass(key: 28, quote: "Talent is God given. Be humble. Fame is man-given. Be grateful. Conceit is self-given. Be careful.", name: "John Wooden", like: 0)
        
        var q29 = QuoteClass(key: 29, quote: "Whether you think you can, or you think you can't, you're right.", name: "Henry Ford", like: 0)
        
        var q30 = QuoteClass(key: 30, quote: "Whatever the mind of man can conceive and believe, it can achieve.", name: "Napoleon Hill", like: 0)
        
        var q31 = QuoteClass(key: 31, quote: "People who say it cannot be done should not interrupt those who are doing it.", name: "George Bernard Shaw", like: 0)
        
        var q32 = QuoteClass(key: 32, quote: "When everything seems to be going against you, remember that the airplane takes off against the wind, not with it.", name: "Henry Ford", like: 0)
        
        var q33 = QuoteClass(key: 33, quote: "Build your own dreams, or someone else will hire you to build theirs.", name: "Farrah Gray", like: 0)
        
        var q34 = QuoteClass(key: 34, quote: "How wonderful it is that nobody need wait a single moment before starting to improve the world.", name: "Anne Frank", like: 0)
        
        var q35 = QuoteClass(key: 35, quote: "I have been impressed with the urgency of doing. Knowing is not enough; we must apply. Being willing is not enough; we must do.", name: "Leonardo Da Vinci", like: 0)
        
        var q36 = QuoteClass(key: 36, quote: "If you want to lift yourself up, lift up someone else.", name: "Booker T. Washington", like: 0)
        
        var q37 = QuoteClass(key: 37, quote: "The way to get started is to quit talking and begin doing.", name: "Walt Disney", like: 0)
        
        var q38 = QuoteClass(key: 38, quote: "What you lack in talent can be made up with desire, hustle, and giving 110% all the time.", name: "Don Zimmer", like: 0)
        
        
        var q39 = QuoteClass(key: 39, quote: "You learn more from failure than from success. Don’t let it stop you. Failure builds character.", name: "Anonymous", like: 0)
        
        var q40 = QuoteClass(key: 40, quote: "People who are crazy enough to think they can change the world, are the ones who do.", name: "Rob Siltanen", like: 0)
        
        var q41 = QuoteClass(key: 41, quote: "The only limit to our realization of tomorrow will be our doubts of today.", name: "Franklin D. Roosevelt", like: 0)
        
        var q42 = QuoteClass(key: 42, quote: "Do what you can with all you have. Wherever you are.", name: "Theodore Roosevelt", like: 0)
        
        var q43 = QuoteClass(key: 43, quote: "You are never too old to set another goal or to dream a new dream.", name: "C.S. Lewis", like: 0)
        
        var q44 = QuoteClass(key: 44, quote: "Things work out best for those who make the best of how things work out.", name: "John Wooden", like: 0)
        
        var q45 = QuoteClass(key: 45, quote: "Today's accomplishments were yesterday's impossibilities.", name: "Robert H. Schuller", like: 0)
        
        
        var q46 = QuoteClass(key: 46, quote: "If you look at what you have in life, you'll always have more.", name: "Oprah Winfrey", like: 0)
        
        var q47 = QuoteClass(key: 47, quote: "You must do the things you think you cannot do.", name: "Eleanor Roosevelt", like: 0)
        
        var q48 = QuoteClass(key: 48, quote: "We must be willing to let go of the life we planned so as to have the life that is waiting for us.", name: "Joeseph Campbell", like: 0)
        
        
        var q49 = QuoteClass(key: 49, quote: "Don't wait. The time will never be just right.", name: "Naploeon Hill", like: 0)
        
        var q50 = QuoteClass(key: 50, quote: "Life is like riding a bicycle. To keep your balance, you must keep moving.", name: "Albert Einstein", like: 0)
        
        var q51 = QuoteClass(key: 51, quote: "If I cannot do great things, I can do small things in a great way.", name: "Martin Luther King Jr.", like: 0)
        
        var q52 = QuoteClass(key: 52, quote: "The only disability in life is a bad attitude.", name: "Scott Hamilton", like: 0)
        
        var q53 = QuoteClass(key: 53, quote: "Some people want it to happen, some wish it would happen, others make it happen.", name: "Michael Jordan", like: 0)
        
        var q54 = QuoteClass(key: 54, quote: "Be who you are and say what you feel, because those who mind don't matter and those who matter don't mind.", name: "Dr. Seuss", like: 0)
        
        var q55 = QuoteClass(key: 55, quote: "The only person you should try to be better than is the person you were yesterday.", name: "Anonymous", like: 0)
        
        var q56 = QuoteClass(key: 56, quote: "If you want to go fast, go alone. If you want to go far, go together.", name: "African Proverb", like: 0)
        
        var q57 = QuoteClass(key: 57, quote: "Ask yourself if what you're doing today will get you closer to where you want to be tomorrow.", name: "Anonymous", like: 0)
        
        
        
        var q58 = QuoteClass(key: 58, quote: "Life may not be the party we hoped for, but while we're here, we should dance.", name: "Anonymous", like: 0)
        
        var q59 = QuoteClass(key: 59, quote: "We are what we repeatedly do. Excellence, then, is not an act, but a habit.", name: "Aristotle", like: 0)
        
        var q60 = QuoteClass(key: 60, quote: "Our greatest glory is not in never falling, but in rising every time we fall.", name: "Confucious", like: 0)
        
        
        var q61 = QuoteClass(key: 61, quote: "It does not matter how slowly you go, as long as you do not stop.", name: "Confucious", like: 0)
        
        var q62 = QuoteClass(key: 62, quote: "Everything you’ve ever wanted is on the other side of fear.", name: "George Addair", like: 0)
        
        var q63 = QuoteClass(key: 63, quote: "Success is not final, failure is not fatal: it is the courage to continue that counts.", name: "Winston Churchill", like: 0)
        
        var q64 = QuoteClass(key: 64, quote: "Hardships often prepare ordinary people for an extraordinary destiny.", name: "C.S. Lewis", like: 0)
        
        var q65 = QuoteClass(key: 65, quote: "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine.", name: "Roy T. Bennett", like: 0)
        
        var q66 = QuoteClass(key: 66, quote: "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear.", name: "Nelson Mandela", like: 0)
        
        var q67 = QuoteClass(key: 67, quote: "Your true success in life begins only when you make the commitment to become excellent at what you do.", name: "Brian Tracy", like: 0)
        
        var q68 = QuoteClass(key: 68, quote: "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going.", name: "Chantal Sutherland", like: 0)
        
        var q69 = QuoteClass(key: 69, quote: "Definiteness of purpose is the starting point of all achievement.", name: "W. Clement Stone", like: 0)
        
        var q70 = QuoteClass(key: 70, quote: "If you believe it will work out, you’ll see opportunities. If you believe it won’t, you will see obstacles.", name: "Wayne Dyer", like: 0)
        
        
        
        var q71 = QuoteClass(key: 71, quote: "Success means doing the best we can with what we have. Success is the doing, not the getting; in the trying, not the triumph. Success is a personal standard, reaching for the highest that is in us, becoming all that we can be.", name: "Zig Ziglar", like: 0)
        
        
        var q72 = QuoteClass(key: 72, quote: "If you set goals and go after them with all the determination you can muster, your gifts will take you places that will amaze you.", name: "Les Brown", like: 0)
        
        var q73 = QuoteClass(key: 73, quote: "Hard times don’t create heroes. It is during the hard times when the ‘hero’ within us is revealed.", name: "Bob Riley", like: 0)
        
        var q74 = QuoteClass(key: 74, quote: "Believe you can and you’re halfway there.", name: "Theodore Roosevelt", like: 0)
        
        var q75 = QuoteClass(key: 75, quote: "Your mind is a powerful thing. When you fill it with positive thoughts, your life will start to change.", name: "Unknown", like: 0)
        
        var q76 = QuoteClass(key: 76, quote: "Start by doing what’s necessary; then do what’s possible; and suddenly you are doing the impossible.", name: "Francis of Assisi", like: 0)
        
        var q77 = QuoteClass(key: 77, quote: "Whatever you hold in your mind on a consistent basis is exactly what you will experience in your life.", name: "Tony Robbins", like: 0)
        
        var q78 = QuoteClass(key: 78, quote: "Most of the important things in the world have been accomplished by people who have kept on trying when there seemed to be no hope at all.", name: "Dale Carnegie", like: 0)
        
        var q79 = QuoteClass(key: 79, quote: "The future belongs to those who believe in the beauty of their dreams.", name: "Franklin D. Roosevelt", like: 0)
        
        var q80 = QuoteClass(key: 80, quote: "Don’t be pushed around by the fears in your mind. Be led by the dreams in your heart.", name: "Roy T. Bennett", like: 0)
        
        
        var q81 = QuoteClass(key: 81, quote: "Character cannot be developed in ease and quiet. Only through experience of trial and suffering can the soul be strengthened, ambition inspired, and success achieved.", name: "Helen Keller", like: 0)
        
        
        
        var q82 = QuoteClass(key: 82, quote: "If you can tune into your purpose and really align with it, setting goals so that your vision is an expression of that purpose, then life flows much more easily.", name: "Jack Canfield", like: 0)
        
        
        var q83 = QuoteClass(key: 83, quote: "Don’t wish it were easier. Wish you were better.", name: "Jim Rohn", like: 0)
        
        var q84 = QuoteClass(key: 84, quote: "It’s not about perfect. It’s about effort. And when you bring that effort every single day, that’s where transformation happens. That’s how change occurs.", name: "Jillian Michaels", like: 0)
        
        var q85 = QuoteClass(key: 85, quote: "Strength doesn’t come from what you can do. It comes from overcoming the things you once thought you couldn’t.", name: "Rikki Rodgers", like: 0)
        
        var q86 = QuoteClass(key: 86, quote: "Learn from the past, set vivid, detailed goals for the future, and live in the only moment of time over which you have any control: now.", name: "Denis Waitley", like: 0)
        
        var q87 = QuoteClass(key: 87, quote: "Fortune always favors the brave, and never helps a man who does not help himself.", name: "P.T. Barnum", like: 0)
        
        var q88 = QuoteClass(key: 88, quote: "The only person you are destined to become is the person you decide to be.", name: "Ralph Waldo Emerson", like: 0)
        
        var q89 = QuoteClass(key: 89, quote: "Perfection is not attainable, but if we chase perfection we can catch excellence.", name: "Vince Lombardi", like: 0)
        
        var q90 = QuoteClass(key: 90, quote: "Life is 10% what happens to you and 90% how you react to it.", name: "Charles R. Swindoll", like: 0)
        
        var q91 = QuoteClass(key: 91, quote: "Inaction breeds doubt and fear. Action breeds confidence and courage. If you want to conquer fear, do not sit home and think about it. Go out and get busy.", name: "Dale Carnegie", like: 0)
        
        var q92 = QuoteClass(key: 92, quote: "Setting goals is the first step into turning the invisible into the visible.", name: "Tony Robbins", like: 0)
        
        
        var q93 = QuoteClass(key: 93, quote: "Remember that not getting what you want is sometimes a wonderful stroke of luck.", name: "Dalai Lama", like: 0)
        
        
        var q94 = QuoteClass(key: 94, quote: "No matter how hard times may get, always hold your head up and be strong; show them you’re not as weak as they think you are.", name: "Anonymous", like: 0)
        
        var q95 = QuoteClass(key: 95, quote: "We may encounter many defeats but we must not be defeated.", name: "Maya Angelou", like: 0)
        
        var q96 = QuoteClass(key: 96, quote: "Twenty years from now you will be more disappointed by the things you didn’t do than by the things you did.", name: "Mark Twain", like: 0)
        
        var q97 = QuoteClass(key: 97, quote: "In order to carry a positive action we must develop here a positive vision.", name: "Dalai Lama", like: 0)
        
        var q98 = QuoteClass(key: 98, quote: "Your time is limited, so don’t waste it living someone else’s life.", name: "Steve Jobs", like: 0)
        
        var q99 = QuoteClass(key: 99, quote: "Be so happy that when others look at you they become happy too.", name: "Anonymous", like: 0)
        
        var q100 = QuoteClass(key: 100, quote: "Challenges are what make life interesting and overcoming them is what makes life meaningful.", name: "Joshua Marine", like: 0)
        
        var q101 = QuoteClass(key: 101, quote: "You cannot afford to live in potential for the rest of your life; at some point, you have to unleash the potential and make your move.", name: "Eric Thomas", like: 0)
        
        var q102 = QuoteClass(key: 102, quote: "Free yourself from your past mistakes, by forgiving yourself for what you have done or went through. Every day is another chance to start over.", name: "Anonymous", like: 0)
        
        var q103 = QuoteClass(key: 103, quote: "If you do what you’ve always done, you’ll get what you’ve always gotten.", name: "Tony Robins", like: 0)
        
        var q104 = QuoteClass(key: 104, quote: "There is only one way to avoid criticism: do nothing, say nothing, and be nothing.", name: "Aristotole", like: 0)
        
        var q105 = QuoteClass(key: 105, quote: "I am thankful for all of those who said NO to me. It’s because of them I’m doing it myself.", name: "Albert Einstein", like: 0)
        
        var q106 = QuoteClass(key: 106, quote: "If you’re offered a seat on a rocket ship, don’t ask what seat! Just get on.", name: "Sheryl Sandberg", like: 0)
        
        var q107 = QuoteClass(key: 107, quote: "You get what you settle for.", name: "Thelma and Louise", like: 0)
        
        var q108 = QuoteClass(key: 108, quote: "Only those who will risk going too far can possibly find out how far one can go.", name: "T. S. Eliot", like: 0)
        
        var q109 = QuoteClass(key: 109, quote: "If you don’t build your dream, someone else will hire you to help them build theirs.", name: "Dhirubhai Ambani", like: 0)
        
        var q110 = QuoteClass(key: 110, quote: "Don’t be too timid and squeamish about your actions. All life is an experiment. The more experiments you make the better.", name: "Ralph Waldo Emerson", like: 0)
        
        var q111 = QuoteClass(key: 111, quote: "And the day came when the risk to remain tight in a bud was more painful than the risk it took to blossom.", name: "Anais Nin", like: 0)
        
        var q112 = QuoteClass(key: 112, quote: "Don’t judge each day by the harvest you reap but by the seeds that you plant.", name: "Robert Louis Stevenson", like: 0)
        
        var q113 = QuoteClass(key: 113, quote: "Pearls don’t lie on the seashore. If you want one, you must dive for it.", name: "Chinese proverb", like: 0)
        
        var q114 = QuoteClass(key: 114, quote: "The first step toward success is taken when you refuse to be a captive of the environment in which you first find yourself.", name: "Mark Caine", like: 0)
        
        var q115 = QuoteClass(key: 115, quote: "The question isn’t who is going to let me; it’s who is going to stop me.", name: "Ayn Rand", like: 0)
        
        var q116 = QuoteClass(key: 116, quote: "It is never too late to be what you might have been.", name: "George Eliot", like: 0)
        
        var q117 = QuoteClass(key: 117, quote: "Life is inherently risky. There is only one big risk you should avoid at all costs, and that is the risk of doing nothing.", name: "Denis Waitley", like: 0)
        
        var q118 = QuoteClass(key: 118, quote: "Nowadays people know the price of everything and the value of nothing.", name: "Oscar Wilde", like: 0)
        
        var q119 = QuoteClass(key: 119, quote: "The best time to plant a tree was 20 years ago. The second best time is now.", name: "Chinese Proverb", like: 0)
        
        var q120 = QuoteClass(key: 120, quote: "Go out on a limb. That’s where the fruit is.", name: "Jimmy Carter", like: 0)
        
        var q121 = QuoteClass(key: 121, quote: "Great minds discuss ideas; Average minds discuss events; small minds discuss people.", name: "Eleanor Roosevelt", like: 0)
        
        var q122 = QuoteClass(key: 122, quote: "A ship in harbor is safe, but that is not what ships are built for.", name: "John A. Shedd", like: 0)
        
        var q123 = QuoteClass(key: 123, quote: "Don’t worry about failures, worry about the chances you miss when you don’t even try.", name: "Jack Canfield", like: 0)
        
        var q124 = QuoteClass(key: 124, quote: "Have the courage to follow your heart and intuition. They somehow know what you truly want to become.", name: "Steve Jobs", like: 0)
        
        var q125 = QuoteClass(key: 125, quote: "Think big and don’t listen to people who tell you it can’t be done. Life is too short to think small.", name: "Tim Ferriss", like: 0)
        
        var q126 = QuoteClass(key: 126, quote: "Everything you’ve ever wanted is on the other side of fear.", name: "George Addair", like: 0)
        
        var q127 = QuoteClass(key: 127, quote: "In order to succeed, your desire for success should be greater than your fear of failure.", name: "Bill Cosby", like: 0)
        
        var q128 = QuoteClass(key: 128, quote: "Your time is limited, so don’t waste it living someone else’s life.", name: "Steve Jobs", like: 0)
        
        var q129 = QuoteClass(key: 129, quote: "You can’t have everything you want, but you can have the things that really matter to you.", name: "Marissa Mayer", like: 0)
        
        var q130 = QuoteClass(key: 130, quote: "If you are not willing to risk the unusual, you will have to settle for the ordinary.", name: "Jim Rohn", like: 0)
        
        var q131 = QuoteClass(key: 131, quote: "We make a living by what we get. We make a life by what we give.", name: "Winston Churchill", like: 0)
        
        var q132 = QuoteClass(key: 132, quote: "Trust your own instinct. Your mistakes might as well be your own, instead of someone else’s.", name: "Billy Wilder", like: 0)
        
        var q133 = QuoteClass(key: 133, quote: "I refuse to accept other people’s ideas of happiness for me. As if there’s a one size fits all standard for happiness.", name: "Kanye West", like: 0)
        
        var q134 = QuoteClass(key: 134, quote: "Knowledge will give you power, but character respect.", name: "Bruce Lee", like: 0)
        
        var q135 = QuoteClass(key: 135, quote: "The future depends on what we do in the present.", name: "Mahatma Gandhi", like: 0)
        
        var q136 = QuoteClass(key: 136, quote: "Nothing is impossible, the word itself says 'I’m possible'!", name: "Audrey Hepburn", like: 0)
        
        var q137 = QuoteClass(key: 137, quote: "I’ve learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel.", name: "Maya Angelou", like: 0)
        
        var q138 = QuoteClass(key: 138, quote: "Whether you think you can or you think you can’t, you’re right.", name: "Henry Ford", like: 0)
        
        var q139 = QuoteClass(key: 139, quote: "Perfection is not attainable, but if we chase perfection we can catch excellence.", name: "Vince Lombardi", like: 0)
        
        var q140 = QuoteClass(key: 140, quote: "Life is 10% what happens to me and 90% of how I react to it.", name: "Charles Swindoll", like: 0)
        
        var q141 = QuoteClass(key: 141, quote: "If you look at what you have in life, you’ll always have more. If you look at what you don’t have in life, you’ll never have enough.", name: "Oprah Winfrey", like: 0)
        
        var q142 = QuoteClass(key: 142, quote: "Remember, no one can make you feel inferior without your consent.", name: "Eleanor Roosevelt", like: 0)
        
        var q143 = QuoteClass(key: 143, quote: "I can’t change the direction of the wind, but I can adjust my sails to always reach my destination.", name: "Jimmy Dean", like: 0)
        
        var q144 = QuoteClass(key: 144, quote: "Believe you can and you’re halfway there.", name: "Theodore Roosevelt", like: 0)
        
        var q145 = QuoteClass(key: 145, quote: "To handle yourself, use your head; to handle others, use your heart.", name: "Eleanor Roosevelt", like: 0)
        
        var q146 = QuoteClass(key: 146, quote: "Too many of us are not living our dreams because we are living our fears.", name: "Les Brown", like: 0)
        
        var q147 = QuoteClass(key: 147, quote: "Do or do not. There is no try.", name: "Yoda", like: 0)
        
        var q148 = QuoteClass(key: 148, quote: "Whatever the mind of man can conceive and believe, it can achieve.", name: "Napoleon Hill", like: 0)
        
        var q149 = QuoteClass(key: 149, quote: "Twenty years from now you will be more disappointed by the things that you didn’t do than by the ones you did do.", name: "Mark Twain", like: 0)
        
        var q150 = QuoteClass(key: 150, quote: "26 times I’ve been trusted to take the game winning shot and missed. I’ve failed over and over and over again in my life. And that is why I succeed.", name: "Michael Jordan", like: 0)
        
        var q151 = QuoteClass(key: 151, quote: "Strive not to be a success, but rather to be of value.", name: "Albert Einstein", like: 0)
        
        var q152 = QuoteClass(key: 152, quote: "I am not a product of my circumstances. I am a product of my decisions.", name: "Stephen Covey", like: 0)
        
        var q153 = QuoteClass(key: 153, quote: "When everything seems to be going against you, remember that the airplane takes off against the wind, not with it.", name: "Henry Ford", like: 0)
        
        var q154 = QuoteClass(key: 154, quote: "The most common way people give up their power is by thinking they don’t have any.", name: "Alice Walker", like: 0)
        
        var q155 = QuoteClass(key: 155, quote: "The most difficult thing is the decision to act, the rest is merely tenacity.", name: "Amelia Earhart", like: 0)
        
        var q156 = QuoteClass(key: 156, quote: "It is during our darkest moments that we must focus to see the light.", name: "Aristotle Onassis", like: 0)
        
        var q157 = QuoteClass(key: 157, quote: "The only way to do great work is to love what you do.", name: "Steve Jobs", like: 0)
        
        var q158 = QuoteClass(key: 158, quote: "Change your thoughts and you change your world.", name: "Norman Vincent Peale", like: 0)
        
        var q159 = QuoteClass(key: 159, quote: "If you hear a voice within you say 'you cannot paint,' then by all means paint and that voice will be silenced.", name: "Vincent Van Gogh", like: 0)
        
        var q160 = QuoteClass(key: 160, quote: "Build your own dreams, or someone else will hire you to build theirs.", name: "Farrah Gray", like: 0)
        
        var q161 = QuoteClass(key: 161, quote: "Remember that not getting what you want is sometimes a wonderful stroke of luck.", name: "Dalai Lama", like: 0)
        
        var q162 = QuoteClass(key: 162, quote: "You can’t use up creativity. The more you use, the more you have.", name: "Maya Angelou", like: 0)
        
        var q163 = QuoteClass(key: 163, quote: "I have learned over the years that when one’s mind is made up, this diminishes fear.", name: "Rosa Parks", like: 0)
        
        var q164 = QuoteClass(key: 164, quote: "I would rather die of passion than of boredom.", name: "Vincent Van Gogh", like: 0)
        
        var q165 = QuoteClass(key: 165, quote: "A truly rich man is one whose children run into his arms when his hands are empty", name: "Anonymous", like: 0)
        
        var q166 = QuoteClass(key: 166, quote: "What’s money? A man is a success if he gets up in the morning and goes to bed at night and in between does what he wants to do.", name: "Bob Dylan", like: 0)
        
        var q167 = QuoteClass(key: 167, quote: "If you want to lift yourself up, lift up someone else.", name: "Booker T. Washington", like: 0)
        
        var q168 = QuoteClass(key: 168, quote: "Limitations live only in our minds. But if we use our imaginations, our possibilities become limitless.", name: "Jamie Paolinetti", like: 0)
        
        var q169 = QuoteClass(key: 169, quote: "Certain things catch your eye, but pursue only those that capture the heart.", name: "Ancient Indian", like: 0)
        
        var q170 = QuoteClass(key: 170, quote: "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us.", name: "Helen Keller", like: 0)
        
        var q171 = QuoteClass(key: 171, quote: "Everything has beauty, but not everyone can see.", name: "Confucius", like: 0)
        
        var q172 = QuoteClass(key: 172, quote: "How wonderful it is that nobody need wait a single moment before starting to improve the world.", name: "Anne Frank", like: 0)
        
        var q173 = QuoteClass(key: 173, quote: "The only person you are destined to become is the person you decide to be.", name: "Ralph Waldo Emerson", like: 0)
        
        var q174 = QuoteClass(key: 174, quote: "We can’t help everyone, but everyone can help someone.", name: "Ronald Reagan", like: 0)
        
        var q175 = QuoteClass(key: 175, quote: "We can easily forgive a child who is afraid of the dark; the real tragedy of life is when men are afraid of the light.", name: "Plato", like: 0)
        
        var q176 = QuoteClass(key: 176, quote: "Nothing will work unless you do.", name: "Maya Angelou", like: 0)
        
        var q177 = QuoteClass(key: 177, quote: "I alone cannot change the world, but I can cast a stone across the water to create many ripples.", name: "Mother Teresa", like: 0)
        
        var q178 = QuoteClass(key: 178, quote: "What we achieve inwardly will change outer reality.", name: "Plutarch", like: 0)
        
        var q179 = QuoteClass(key: 179, quote: "Start where you are. Use what you have. Do what you can.", name: "Arthur Ashe", like: 0)
        
        var q180 = QuoteClass(key: 180, quote: "Life is not measured by the number of breaths we take, but by the moments that take our breath away.", name: "Maya Angelou", like: 0)
        
        var q181 = QuoteClass(key: 181, quote: "Happiness is not something readymade. It comes from your own actions.", name: "Dalai Lama", like: 0)
        
        var q182 = QuoteClass(key: 182, quote: "If the wind will not serve, take to the oars.", name: "Latin Proverb", like: 0)
        
        var q183 = QuoteClass(key: 183, quote: "Challenges are what make life interesting and overcoming them is what makes life meaningful.", name: "Joshua J. Marine", like: 0)
        
        var q184 = QuoteClass(key: 184, quote: "I didn’t fail the test. I just found 100 ways to do it wrong.", name: "Benjamin Franklin", like: 0)
        
        var q185 = QuoteClass(key: 185, quote: "The person who says it cannot be done should not interrupt the person who is doing it.", name: "Chinese Proverb", like: 0)
        
        var q186 = QuoteClass(key: 186, quote: "There are no traffic jams along the extra mile.", name: "Roger Staubach", like: 0)
        
        var q187 = QuoteClass(key: 187, quote: "You become what you believe.", name: "Oprah Winfrey", like: 0)
        
        var q188 = QuoteClass(key: 188, quote: "If you want your children to turn out well, spend twice as much time with them, and half as much money.", name: "Abigail Van Buren", like: 0)
        
        var q189 = QuoteClass(key: 189, quote: "It does not matter how slowly you go as long as you do not stop.", name: "Confucius", like: 0)
        
        var q190 = QuoteClass(key: 190, quote: "Life is about making an impact, not about making an income.", name: "Kevin Kruse", like: 0)
        
        var q191 = QuoteClass(key: 191, quote: "You miss 100% of the shots you don’t take.", name: "Wayne Gretzky", like: 0)
        
        var q192 = QuoteClass(key: 192, quote: "Every strike brings me closer to the next home run.", name: "Babe Ruth", like: 0)
        
        var q193 = QuoteClass(key: 193, quote: "Life isn't about getting and having, it's about giving and being.", name: "Kevin Kruse", like: 0)
        
        var q194 = QuoteClass(key: 194, quote: "Eighty percent of success is showing up.", name: "Woody Allen", like: 0)
        
        var q195 = QuoteClass(key: 195, quote: "Winning isn’t everything, but wanting to win is.", name: "Vince Lombardi", like: 0)
        
        var q196 = QuoteClass(key: 196, quote: "Every child is an artist. The problem is how to remain an artist once he grows up.", name: "Pablo Picasso", like: 0)
        
        var q197 = QuoteClass(key: 197, quote: "You can never cross the ocean until you have the courage to lose sight of the shore.", name: "Christopher Columbus", like: 0)
        
        var q198 = QuoteClass(key: 198, quote: "Either you run the day, or the day runs you.", name: "Jim Rohn", like: 0)
        
        var q199 = QuoteClass(key: 199, quote: "The two most important days in your life are the day you are born and the day you find out why.", name: "Mark Twain", like: 0)
        
        var q200 = QuoteClass(key: 200, quote: "People often say that motivation doesn’t last. Well, neither does bathing. That’s why we recommend it daily.", name: "Zig Ziglar", like: 0)
        
        var q201 = QuoteClass(key: 201, quote: "Life shrinks or expands in proportion to one's courage.", name: "Anais Nin", like: 0)
        
        var q202 = QuoteClass(key: 202, quote: "Dreaming, after all, is a form of planning.", name: "Gloria Steinem", like: 0)
        
        var q203 = QuoteClass(key: 203, quote: "Nearly all men can stand adversity, but if you want to test a man's character, give him power.", name: "Abraham Lincoln", like: 0)
        
        var q204 = QuoteClass(key: 204, quote: "Character is like a tree and reputation like a shadow. The shadow is what we think of it; the tree is the real thing.", name: "Abraham Lincoln", like: 0)
        
        var q205 = QuoteClass(key: 205, quote: "Our character is what we do when we think no one is looking.", name: "H. Jackson Brown, Jr.", like: 0)
        
        var q206 = QuoteClass(key: 206, quote: "Show class, have pride, and display character. If you do, winning takes care of itself.", name: "Paul Bryant", like: 0)
        
        var q207 = QuoteClass(key: 207, quote: "The final forming of a person's character lies in their own hands.", name: "Anne Frank", like: 0)
        
        var q208 = QuoteClass(key: 208, quote: "Winning takes talent, to repeat takes character.", name: "John Wooden", like: 0)
        
        var q209 = QuoteClass(key: 209, quote: "Be more concerned with your character than your reputation, because your character is what you really are, while your reputation is merely what others think you are.", name: "John Wooden", like: 0)
        
        var q210 = QuoteClass(key: 210, quote: "A man's character may be learned from the adjectives which he habitually uses in conversation.", name: "Mark Twain", like: 0)
        
        var q211 = QuoteClass(key: 211, quote: "There are too many people who think that the only thing that's right is to get by, and the only thing that's wrong is to get caught.", name: "J. C. Watts", like: 0)
        
        var q212 = QuoteClass(key: 212, quote: "If I take care of my character, my reputation will take care of me.", name: "Dwight L. Moody", like: 0)
        
        var q213 = QuoteClass(key: 213, quote: "Leadership is a potent combination of strategy and character. But if you must be without one, be without the strategy.", name: "Norman Schwarzkopf", like: 0)
        
        var q214 = QuoteClass(key: 214, quote: "Most people say that it is the intellect which makes a great scientist. They are wrong: it is character.", name: "Albert Einstein", like: 0)
        
        var q215 = QuoteClass(key: 215, quote: "Ability may get you to the top, but it takes character to keep you there.", name: "Stevie Wonder", like: 0)
        
        var q216 = QuoteClass(key: 216, quote: "A positive attitude can really make dreams come true - it did for me.", name: "David Bailey", like: 0)
        
        var q217 = QuoteClass(key: 217, quote: "If you don't like something, change it. If you can't change it, change your attitude.", name: "Maya Angelo", like: 0)
        
        var q218 = QuoteClass(key: 218, quote: "Leadership is practiced not so much in words as in attitude and in actions.", name: "Harold S. Geneen", like: 0)
        
        var q219 = QuoteClass(key: 219, quote: "Attitude is a little thing that makes a big difference.", name: "Winston Churchill", like: 0)
        
        var q220 = QuoteClass(key: 220, quote: "Being sexy is all about attitude, not body type. It's a state of mind.", name: "Amisha Patel", like: 0)
        
        var q221 = QuoteClass(key: 221, quote: "People may hear your words, but they feel your attitude.", name: "John C. Maxwell", like: 0)
        
        var q222 = QuoteClass(key: 222, quote: "Your attitude, not your aptitude, will determine your altitude.", name: "Zig Ziglar", like: 0)
        
        var q223 = QuoteClass(key: 223, quote: "A positive attitude causes a chain reaction of positive thoughts, events and outcomes. It is a catalyst and it sparks extraordinary results.", name: "Wade Boggs", like: 0)
        
        var q224 = QuoteClass(key: 224, quote: "A healthy attitude is contagious but don't wait to catch it from others. Be a carrier.", name: "Tom Stoppard", like: 0)
        
        var q225 = QuoteClass(key: 225, quote: "The only disability in life is a bad attitude.", name: "Scott Hamilton", like: 0)
        
        var q226 = QuoteClass(key: 226, quote: "Choosing to be positive and having a grateful attitude is going to determine how you're going to live your life.", name: "Joel Osteen", like: 0)
        
        var q227 = QuoteClass(key: 227, quote: "For success, attitude is equally as important as ability.", name: "Walter Scott", like: 0)
        
        var q228 = QuoteClass(key: 228, quote: "Our attitude towards others determines their attitude towards us.", name: "Earl Nightingale", like: 0)
        
        var q229 = QuoteClass(key: 229, quote: "My attitude is that if you push me towards something that you think is a weakness, then I will turn that perceived weakness into a strength.", name: "Michael Jordan", like: 0)
        
        var q230 = QuoteClass(key: 230, quote: "Adopting a really positive attitude can work wonders to adding years to your life, a spring to your step, a sparkle to your eye, and all of that.", name: "Christie Brinkley", like: 0)
        
        var q231 = QuoteClass(key: 231, quote: "The remarkable thing is, we have a choice everyday regarding the attitude we will embrace for that day.", name: "Charles R. Swindoll", like: 0)
        
        var q232 = QuoteClass(key: 232, quote: "Optimism is a success builder; pessimism an achievement killer.", name: "Orison Swett Marden", like: 0)
        
        var q233 = QuoteClass(key: 233, quote: "Age and size are only numbers. It's the attitude you bring to clothes that make the difference.", name: "Donna Karan", like: 0)
        
        var q234 = QuoteClass(key: 234, quote: "Always keep that happy attitude. Pretend that you are holding a beautiful fragrant bouquet.", name: "Earl Nightingale", like: 0)
        
        var q235 = QuoteClass(key: 235, quote: "If there is no struggle, there is no progress.", name: "Frederick Douglass", like: 0)
        
        var q236 = QuoteClass(key: 236, quote: "Progress is impossible without change, and those who cannot change their minds cannot change anything.", name: "George Bernard Shaw", like: 0)
        
        var q237 = QuoteClass(key: 237, quote: "Progress lies not in enhancing what is, but in advancing toward what will be.", name: "Khalil Gibran", like: 0)
        
        var q238 = QuoteClass(key: 238, quote: "Success is steady progress toward one's personal goals.", name: "Jim Rohn", like: 0)
        
        var q239 = QuoteClass(key: 239, quote: "Behold the turtle. He makes progress only when he sticks his neck out.", name: "James Bryant Conant", like: 0)
        
        var q240 = QuoteClass(key: 240, quote: "Changes and progress very rarely are gifts from above. They come out of struggles from below.", name: "Noam Chomsky", like: 0)
        
        var q241 = QuoteClass(key: 241, quote: "The aim of argument, or of discussion, should not be victory, but progress.", name: "Joseph Joubert", like: 0)
        
        var q242 = QuoteClass(key: 242, quote: "We all have a tendency to avoid our weaknesses. When we do that, we never progress or get any better.", name: "Jocko Willink", like: 0)
        
        var q243 = QuoteClass(key: 243, quote: "The power to question is the basis of all human progress.", name: "Indira Gandhi", like: 0)
        
        var q244 = QuoteClass(key: 244, quote: "The keystone of successful business is cooperation. Friction retards progress.", name: "James Cash Penney", like: 0)
        
        var q245 = QuoteClass(key: 245, quote: "The art of progress is to preserve order amid change and to preserve change amid order.", name: "Alfred North Whitehead", like: 0)
        
        var q246 = QuoteClass(key: 246, quote: "Whenever an individual or a business decides that success has been attained, progress stops.", name: "Thomas J. Watson", like: 0)
        
        var q247 = QuoteClass(key: 247, quote: "Racial prejudice, anti-Semitism, or hatred of anyone with different beliefs has no place in the human mind or heart.", name: "Billy Graham", like: 0)
        
        var q248 = QuoteClass(key: 248, quote: "The human mind is our fundamental resource.", name: "John F. Kennedy", like: 0)
        
        var q249 = QuoteClass(key: 249, quote: "For the human mind is seldom at stay: If you do not grow better, you will most undoubtedly grow worse.", name: "Samuel Richardson", like: 0)
        
        var q250 = QuoteClass(key: 250, quote: "Do not dwell in the past, do not dream of the future, concentrate the mind on the present moment.", name: "Buddha", like: 0)
        
        var q251 = QuoteClass(key: 251, quote: "It is the mark of an educated mind to be able to entertain a thought without accepting it.", name: "Aristotle", like: 0)
        
        var q252 = QuoteClass(key: 252, quote: "Age is a case of mind over matter. If you don't mind, it don't matter.", name: "Satchel Paige", like: 0)
        
        var q253 = QuoteClass(key: 253, quote: "I can have peace of mind only when I forgive rather than judge.", name: "Gerald Jampolsky", like: 0)
        
        var q254 = QuoteClass(key: 254, quote: "There are no shortcuts to any place worth going.", name: "Helen Keller", like: 0)
        
        var q255 = QuoteClass(key: 255, quote: "There's no substitute for hard work.", name: "Thomas Edison", like: 0)
        
        var q256 = QuoteClass(key: 256, quote: "There is no elevator to success. You have to take the stairs.", name: "Anonymous", like: 0)
        
        var q257 = QuoteClass(key: 257, quote: "There are two educations. One should teach us how to make a living and the other how to live.", name: "John Adams", like: 0)
        
        var q258 = QuoteClass(key: 258, quote: "No matter what you look like or think you look like, you’re special and loved and perfect just the way you are.", name: "Ariel Winter", like: 0)
        
        var q259 = QuoteClass(key: 259, quote: "Life is like a camera. Focus on what’s important. Capture the good times. And if things don’t work out, just take another shot.", name: "Ziad K. Abdelnour", like: 0)
        
        var q260 = QuoteClass(key: 260, quote: "In school, you’re taught a lesson and then given a test. In life, you’re given a test that teaches you a lesson.", name: "Tom Bodett", like: 0)
        
        var q261 = QuoteClass(key: 261, quote: "Success consists of going from failure to failure without loss of enthusiasm.", name: "Winston Churchill", like: 0)
        
        var q262 = QuoteClass(key: 262, quote: "With the new day comes new strength and new thoughts.", name: "Eleanor Roosevelt", like: 0)
        
        var q263 = QuoteClass(key: 263, quote: "The past cannot be changed. The future is yet in your power.", name: "Anonymous", like: 0)
        
        var q264 = QuoteClass(key: 264, quote: "If you're going through hell, keep going.", name: "Winston Churchill", like: 0)
        
        var q265 = QuoteClass(key: 265, quote: "A creative man is motivated by the desire to achieve, not by the desire to beat others.", name: "Ayn Rand", like: 0)
        
        var q266 = QuoteClass(key: 266, quote: "he secret of getting ahead is getting started.", name: "Mark Twain", like: 0)
        
        var q267 = QuoteClass(key: 267, quote: "Set your goals high, and don't stop till you get there.", name: "Bo Jackson", like: 0)
        
        var q268 = QuoteClass(key: 268, quote: "If you want to conquer fear, don't sit home and think about it. Go out and get busy.", name: "Dale Carnegie", like: 0)
        
        var q269 = QuoteClass(key: 269, quote: "What you do today can improve all your tomorrows.", name: "Ralph Marston", like: 0)
        
        var q270 = QuoteClass(key: 270, quote: "Well done is better than well said.", name: "Benjamin Franklin", like: 0)
        
        var q271 = QuoteClass(key: 271, quote: "Perseverance is not a long race; it is many short races one after the other.", name: "Walter Elliot", like: 0)
        
        var q272 = QuoteClass(key: 272, quote: "Don't watch the clock; do what it does. Keep going.", name: "Levenson", like: 0)
        
        var q273 = QuoteClass(key: 273, quote: "By failing to prepare, you are preparing to fail.", name: "Benjamin Franklin", like: 0)
        
        var q274 = QuoteClass(key: 274, quote: "You are never too old to set another goal or to dream a new dream.", name: "Les Brown", like: 0)
        
        var q275 = QuoteClass(key: 275, quote: "Do something wonderful, people may imitate it.", name: "Albert Schweitzer", like: 0)
        
        var q276 = QuoteClass(key: 276, quote: "Perseverance is failing 19 times and succeeding the 20th.", name: "Julie Andrews", like: 0)
        
        var q277 = QuoteClass(key: 277, quote: "You can't build a reputation on what you are going to do.", name: "Henry Ford", like: 0)
        
        var q278 = QuoteClass(key: 278, quote: "The hardships that I encountered in the past will help me succeed in the future.", name: "Phillip Emeagwali", like: 0)
        
        var q279 = QuoteClass(key: 279, quote: "Small deeds done are better than great deeds planned.", name: "Peter Marshall", like: 0)
        
        var q280 = QuoteClass(key: 280, quote: "The wise does at once what the fool does at last.", name: "Baltasar Gracian", like: 0)
        
        var q281 = QuoteClass(key: 281, quote: "Motivation will almost always beat mere talent.", name: "Norman Ralph Augustine", like: 0)
        
        var q282 = QuoteClass(key: 282, quote: "Once you replace negative thoughts with positive ones, you'll start having positive results.", name: "Willie Nelson", like: 0)
        
        var q283 = QuoteClass(key: 283, quote: "When you think positive, good things happen.", name: "Matt Kemp", like: 0)
        
        var q284 = QuoteClass(key: 284, quote: "In every day, there are 1,440 minutes. That means we have 1,440 daily opportunities to make a positive impact.", name: "Les Brown", like: 0)
        
        var q285 = QuoteClass(key: 285, quote: "Positive thinking will let you do everything better than negative thinking will.", name: "Zig Ziglar", like: 0)
        
        var q286 = QuoteClass(key: 286, quote: "It's amazing. Life changes very quickly, in a very positive way, if you let it.", name: "Lindsey Vonn", like: 0)
        
        var q287 = QuoteClass(key: 287, quote: "If you run into a wall, don’t turn around and give up. Figure out how to climb it, go through it, or work around it.", name: "Michael Jordan", like: 0)
        
        var q288 = QuoteClass(key: 288, quote: "I hated every minute of training, but I said, ‘Don’t quit. Suffer now and live the rest of your life a champion’.", name: "Muhammad Ali", like: 0)
        
        var q289 = QuoteClass(key: 289, quote: "Persistence can change failure into extraordinary achievement.", name: "Matt Biondi", like: 0)
        
        var q290 = QuoteClass(key: 290, quote: "He who is not courageous enough to take risks will accomplish nothing in life.", name: "Muhammad Ali", like: 0)
        
        var q291 = QuoteClass(key: 291, quote: "There may be people that have more talent than you, but there’s no excuse for anyone to work harder than you do.", name: "Derek Jeter", like: 0)
        
        var q292 = QuoteClass(key: 292, quote: "It isn’t the mountains ahead to climb that wear you out; it’s the pebble in your shoe.", name: "Muhammad Ali", like: 0)
        
        var q293 = QuoteClass(key: 293, quote: "Hustle until your haters ask if you are hiring.", name: "Anonymous", like: 0)
        
        var q294 = QuoteClass(key: 294, quote: "If you can’t fly, then run. If you can’t run, then walk. If you can’t walk, then crawl, but whatever you do, keep moving forward.", name: "Martin Luther King", like: 0)
        
        var q295 = QuoteClass(key: 295, quote: "Whatever you are, be a good one.", name: "Abraham Lincoln", like: 0)
        
        var q296 = QuoteClass(key: 296, quote: "Stay away from negative people, they have a problem for every solution.", name: "Albert Einstein", like: 0)
        
        var q297 = QuoteClass(key: 297, quote: "Be who you are and say what you feel, because those who mind don’t matter and those who matter don’t mind.", name: "Dr Seuss", like: 0)
        
        var q298 = QuoteClass(key: 298, quote: "A day without laughter is a day wasted.", name: "Charlie Chaplin", like: 0)
        
        var q299 = QuoteClass(key: 299, quote: "A pessimist sees the difficulty in every opportunity; an optimist sees the opportunity in every difficulty.", name: "Winston Churchill", like: 0)
    
        var q300 = QuoteClass(key: 300, quote: "Be sure what you are doing today is getting you closer to where you want to be tomorrow.", name: "Anonymous", like: 0)
        
        var q301 = QuoteClass(key: 301, quote: "Look for something positive in each day, even if some days you have to look a little harder.", name: "Anonymous", like: 0)
        
        var q302 = QuoteClass(key: 302, quote: "What your real friends know about you is far more important than what your facebook friends think about you.", name: "Coach Mike", like: 0)
        
        var q303 = QuoteClass(key: 303, quote: "Wherever you go, no matter what the weather, always take your own sunshine.", name: "Anthony J D’angelo", like: 0)
        
        
        var q304 = QuoteClass(key: 304, quote: "A head full of fears has no space for dreams.", name: "Anonymous", like: 0)
        
        var q305 = QuoteClass(key: 305, quote: "Be somebody who makes everybody feel like somebody.", name: "Anonymous", like: 0)
        
        var q306 = QuoteClass(key: 306, quote: "Always believe in yourself, because if you don’t, then who will?", name: "Marilyn Monroe", like: 0)
        
        var q307 = QuoteClass(key: 307, quote: "Life is not always the party we hoped for but it’s always a good idea to dance.", name: "Anonymous", like: 0)
        
        var q308 = QuoteClass(key: 308, quote: "Try never to be the smartest person in the room. And if you are, invite smarter people or find a different room.", name: "Michael Dell", like: 0)
        
        var q309 = QuoteClass(key: 309, quote: "Talent is God given. Be humble. Fame is man-given. Be grateful. Conceit is self-given. Be careful.", name: "John Wooden", like: 0)
        
        var q310 = QuoteClass(key: 310, quote: "Every day can be a good day, if you let it.", name: "Coach Mike", like: 0)
        
        var q311 = QuoteClass(key: 311, quote: "You can’t finish if you don’t start. What are you waiting for?", name: "Coach Mike", like: 0)
        
        var q312 = QuoteClass(key: 312, quote: "A double negative is a positive, so don’t not try.", name: "Coach Mike", like: 0)
        
        var q313 = QuoteClass(key: 313, quote: "KGB my friend, keep getting better.", name: "Coach Mike", like: 0)
        
        var q314 = QuoteClass(key: 314, quote: "Yeah, but let’s look at what’s NOT wrong and build on that?", name: "Coach Mike", like: 0)
        
        var q315 = QuoteClass(key: 315, quote: "If your actions inspire others to dream more, learn more, do more and become more, you are a leader.", name: "Simon Sinek", like: 0)
        
        var q316 = QuoteClass(key: 316, quote: "You can easily judge the character of a man by how he treats those who can do nothing for him.", name: "Simon Sinek", like: 0)
        
        var q317 = QuoteClass(key: 317, quote: "Every storm runs out of rain.", name: "Gary Allan", like: 0)
        
        var q318 = QuoteClass(key: 318, quote: "Some people can’t believe in themselves until someone else believes in them first.", name: "Sean Maguire, from Good Will Hunting", like: 0)
        
        var q319 = QuoteClass(key: 319, quote: "Life moves pretty fast. If you don’t stop and look around once in a while, you could miss it.", name: "Ferris, from Ferris Bueller’s Day Off", like: 0)
        
        
        
        
        
        quoteCells.append(q0)
        quoteCells.append(q1)
        quoteCells.append(q2)
        quoteCells.append(q3)
        quoteCells.append(q4)
        quoteCells.append(q5)
        quoteCells.append(q6)
        quoteCells.append(q7)
        quoteCells.append(q8)
        quoteCells.append(q9)
        quoteCells.append(q10)
        quoteCells.append(q11)
        quoteCells.append(q12)
        quoteCells.append(q13)
        quoteCells.append(q14)
        quoteCells.append(q15)
        quoteCells.append(q16)
        quoteCells.append(q17)
        quoteCells.append(q18)
        quoteCells.append(q19)
        quoteCells.append(q20)
        quoteCells.append(q21)
        quoteCells.append(q22)
        quoteCells.append(q23)
        quoteCells.append(q24)
        quoteCells.append(q25)
        quoteCells.append(q26)
        quoteCells.append(q27)
        quoteCells.append(q28)
        quoteCells.append(q29)
        quoteCells.append(q30)
        quoteCells.append(q31)
        quoteCells.append(q32)
        quoteCells.append(q33)
        quoteCells.append(q34)
        quoteCells.append(q35)
        quoteCells.append(q36)
        quoteCells.append(q37)
        quoteCells.append(q38)
        quoteCells.append(q39)
        quoteCells.append(q40)
        quoteCells.append(q41)
        quoteCells.append(q42)
        quoteCells.append(q43)
        quoteCells.append(q44)
        quoteCells.append(q45)
        quoteCells.append(q46)
        quoteCells.append(q47)
        quoteCells.append(q48)
        quoteCells.append(q49)
        quoteCells.append(q50)
        quoteCells.append(q51)
        quoteCells.append(q52)
        quoteCells.append(q53)
        quoteCells.append(q54)
        quoteCells.append(q55)
        quoteCells.append(q56)
        quoteCells.append(q57)
        quoteCells.append(q58)
        quoteCells.append(q59)
        quoteCells.append(q60)
        quoteCells.append(q61)
        quoteCells.append(q62)
        quoteCells.append(q63)
        quoteCells.append(q64)
        quoteCells.append(q65)
        quoteCells.append(q66)
        quoteCells.append(q67)
        quoteCells.append(q68)
        quoteCells.append(q69)
        quoteCells.append(q70)
        quoteCells.append(q71)
        quoteCells.append(q72)
        quoteCells.append(q73)
        quoteCells.append(q74)
        quoteCells.append(q75)
        quoteCells.append(q76)
        quoteCells.append(q77)
        quoteCells.append(q78)
        quoteCells.append(q79)
        quoteCells.append(q80)
        quoteCells.append(q81)
        quoteCells.append(q82)
        quoteCells.append(q83)
        quoteCells.append(q84)
        quoteCells.append(q85)
        quoteCells.append(q86)
        quoteCells.append(q87)
        quoteCells.append(q88)
        quoteCells.append(q89)
        quoteCells.append(q90)
        quoteCells.append(q91)
        quoteCells.append(q92)
        quoteCells.append(q93)
        quoteCells.append(q94)
        quoteCells.append(q95)
        quoteCells.append(q96)
        quoteCells.append(q97)
        quoteCells.append(q98)
        quoteCells.append(q99)
        quoteCells.append(q100)
        quoteCells.append(q101)
        quoteCells.append(q102)
        quoteCells.append(q103)
        quoteCells.append(q104)
        quoteCells.append(q105)
        quoteCells.append(q106)
        quoteCells.append(q107)
        quoteCells.append(q108)
        quoteCells.append(q109)
        quoteCells.append(q110)
        quoteCells.append(q111)
        quoteCells.append(q112)
        quoteCells.append(q113)
        quoteCells.append(q114)
        quoteCells.append(q115)
        quoteCells.append(q116)
        quoteCells.append(q117)
        quoteCells.append(q118)
        quoteCells.append(q119)
        quoteCells.append(q120)
        quoteCells.append(q121)
        quoteCells.append(q122)
        quoteCells.append(q123)
        quoteCells.append(q124)
        quoteCells.append(q125)
        quoteCells.append(q126)
        quoteCells.append(q127)
        quoteCells.append(q128)
        quoteCells.append(q129)
        quoteCells.append(q130)
        quoteCells.append(q131)
        quoteCells.append(q132)
        quoteCells.append(q133)
        quoteCells.append(q134)
        quoteCells.append(q135)
        quoteCells.append(q136)
        quoteCells.append(q137)
        quoteCells.append(q138)
        quoteCells.append(q139)
        quoteCells.append(q140)
        quoteCells.append(q141)
        quoteCells.append(q142)
        quoteCells.append(q143)
        quoteCells.append(q144)
        quoteCells.append(q145)
        quoteCells.append(q146)
        quoteCells.append(q147)
        quoteCells.append(q148)
        quoteCells.append(q149)
        quoteCells.append(q150)
        quoteCells.append(q151)
        quoteCells.append(q152)
        quoteCells.append(q153)
        quoteCells.append(q154)
        quoteCells.append(q155)
        quoteCells.append(q156)
        quoteCells.append(q157)
        quoteCells.append(q158)
        quoteCells.append(q159)
        quoteCells.append(q160)
        quoteCells.append(q161)
        quoteCells.append(q162)
        quoteCells.append(q163)
        quoteCells.append(q164)
        quoteCells.append(q165)
        quoteCells.append(q166)
        quoteCells.append(q167)
        quoteCells.append(q168)
        quoteCells.append(q169)
        quoteCells.append(q170)
        quoteCells.append(q171)
        quoteCells.append(q172)
        quoteCells.append(q173)
        quoteCells.append(q174)
        quoteCells.append(q175)
        quoteCells.append(q176)
        quoteCells.append(q177)
        quoteCells.append(q178)
        quoteCells.append(q179)
        quoteCells.append(q180)
        quoteCells.append(q181)
        quoteCells.append(q182)
        quoteCells.append(q183)
        quoteCells.append(q184)
        quoteCells.append(q185)
        quoteCells.append(q186)
        quoteCells.append(q187)
        quoteCells.append(q188)
        quoteCells.append(q189)
        quoteCells.append(q190)
        quoteCells.append(q191)
        quoteCells.append(q192)
        quoteCells.append(q193)
        quoteCells.append(q194)
        quoteCells.append(q195)
        quoteCells.append(q196)
        quoteCells.append(q197)
        quoteCells.append(q198)
        quoteCells.append(q199)
        quoteCells.append(q200)
        quoteCells.append(q201)
        quoteCells.append(q202)
        quoteCells.append(q203)
        quoteCells.append(q204)
        quoteCells.append(q205)
        quoteCells.append(q206)
        quoteCells.append(q207)
        quoteCells.append(q208)
        quoteCells.append(q209)
        quoteCells.append(q210)
        quoteCells.append(q211)
        quoteCells.append(q212)
        quoteCells.append(q213)
        quoteCells.append(q214)
        quoteCells.append(q215)
        quoteCells.append(q216)
        quoteCells.append(q217)
        quoteCells.append(q218)
        quoteCells.append(q219)
        quoteCells.append(q220)
        quoteCells.append(q221)
        quoteCells.append(q222)
        quoteCells.append(q223)
        quoteCells.append(q224)
        quoteCells.append(q225)
        quoteCells.append(q226)
        quoteCells.append(q227)
        quoteCells.append(q228)
        quoteCells.append(q229)
        quoteCells.append(q230)
        quoteCells.append(q231)
        quoteCells.append(q232)
        quoteCells.append(q233)
        quoteCells.append(q234)
        quoteCells.append(q235)
        quoteCells.append(q236)
        quoteCells.append(q237)
        quoteCells.append(q238)
        quoteCells.append(q239)
        quoteCells.append(q240)
        quoteCells.append(q241)
        quoteCells.append(q242)
        quoteCells.append(q243)
        quoteCells.append(q244)
        quoteCells.append(q245)
        quoteCells.append(q246)
        quoteCells.append(q247)
        quoteCells.append(q248)
        quoteCells.append(q249)
        quoteCells.append(q250)
        quoteCells.append(q251)
        quoteCells.append(q252)
        quoteCells.append(q253)
        quoteCells.append(q254)
        quoteCells.append(q255)
        quoteCells.append(q256)
        quoteCells.append(q257)
        quoteCells.append(q258)
        quoteCells.append(q259)
        quoteCells.append(q260)
        quoteCells.append(q261)
        quoteCells.append(q262)
        quoteCells.append(q263)
        quoteCells.append(q264)
        quoteCells.append(q265)
        quoteCells.append(q266)
        quoteCells.append(q267)
        quoteCells.append(q268)
        quoteCells.append(q269)
        quoteCells.append(q270)
        quoteCells.append(q271)
        quoteCells.append(q272)
        quoteCells.append(q273)
        quoteCells.append(q274)
        quoteCells.append(q275)
        quoteCells.append(q276)
        quoteCells.append(q277)
        quoteCells.append(q278)
        quoteCells.append(q279)
        quoteCells.append(q280)
        quoteCells.append(q281)
        quoteCells.append(q282)
        quoteCells.append(q283)
        quoteCells.append(q284)
        quoteCells.append(q285)
        quoteCells.append(q286)
        quoteCells.append(q287)
        quoteCells.append(q288)
        quoteCells.append(q289)
        quoteCells.append(q290)
        quoteCells.append(q291)
        quoteCells.append(q292)
        quoteCells.append(q293)
        quoteCells.append(q294)
        quoteCells.append(q295)
        quoteCells.append(q296)
        quoteCells.append(q297)
        quoteCells.append(q298)
        quoteCells.append(q299)
        quoteCells.append(q300)
        quoteCells.append(q301)
        quoteCells.append(q302)
        quoteCells.append(q303)
        quoteCells.append(q304)
        quoteCells.append(q305)
        quoteCells.append(q306)
        quoteCells.append(q307)
        quoteCells.append(q308)
        quoteCells.append(q309)
        quoteCells.append(q310)
        quoteCells.append(q311)
        quoteCells.append(q312)
        quoteCells.append(q313)
        quoteCells.append(q314)
        quoteCells.append(q315)
        quoteCells.append(q316)
        quoteCells.append(q317)
        quoteCells.append(q318)
        quoteCells.append(q319)
        
        
        
        
        
        quoteCellsB.append(q0)
        quoteCellsB.append(q1)
        quoteCellsB.append(q2)
        quoteCellsB.append(q3)
        quoteCellsB.append(q4)
        quoteCellsB.append(q5)
        quoteCellsB.append(q6)
        quoteCellsB.append(q7)
        quoteCellsB.append(q8)
        quoteCellsB.append(q9)
        quoteCellsB.append(q10)
        quoteCellsB.append(q11)
        quoteCellsB.append(q12)
        quoteCellsB.append(q13)
        quoteCellsB.append(q14)
        quoteCellsB.append(q15)
        quoteCellsB.append(q16)
        quoteCellsB.append(q17)
        quoteCellsB.append(q18)
        quoteCellsB.append(q19)
        quoteCellsB.append(q20)
        quoteCellsB.append(q21)
        quoteCellsB.append(q22)
        quoteCellsB.append(q23)
        quoteCellsB.append(q24)
        quoteCellsB.append(q25)
        quoteCellsB.append(q26)
        quoteCellsB.append(q27)
        quoteCellsB.append(q28)
        quoteCellsB.append(q29)
        quoteCellsB.append(q30)
        quoteCellsB.append(q31)
        quoteCellsB.append(q32)
        quoteCellsB.append(q33)
        quoteCellsB.append(q34)
        quoteCellsB.append(q35)
        quoteCellsB.append(q36)
        quoteCellsB.append(q37)
        quoteCellsB.append(q38)
        quoteCellsB.append(q39)
        quoteCellsB.append(q40)
        quoteCellsB.append(q41)
        quoteCellsB.append(q42)
        quoteCellsB.append(q43)
        quoteCellsB.append(q44)
        quoteCellsB.append(q45)
        quoteCellsB.append(q46)
        quoteCellsB.append(q47)
        quoteCellsB.append(q48)
        quoteCellsB.append(q49)
        quoteCellsB.append(q50)
        quoteCellsB.append(q51)
        quoteCellsB.append(q52)
        quoteCellsB.append(q53)
        quoteCellsB.append(q54)
        quoteCellsB.append(q55)
        quoteCellsB.append(q56)
        quoteCellsB.append(q57)
        quoteCellsB.append(q58)
        quoteCellsB.append(q59)
        quoteCellsB.append(q60)
        quoteCellsB.append(q61)
        quoteCellsB.append(q62)
        quoteCellsB.append(q63)
        quoteCellsB.append(q64)
        quoteCellsB.append(q65)
        quoteCellsB.append(q66)
        quoteCellsB.append(q67)
        quoteCellsB.append(q68)
        quoteCellsB.append(q69)
        quoteCellsB.append(q70)
        quoteCellsB.append(q71)
        quoteCellsB.append(q72)
        quoteCellsB.append(q73)
        quoteCellsB.append(q74)
        quoteCellsB.append(q75)
        quoteCellsB.append(q76)
        quoteCellsB.append(q77)
        quoteCellsB.append(q78)
        quoteCellsB.append(q79)
        quoteCellsB.append(q80)
        quoteCellsB.append(q81)
        quoteCellsB.append(q82)
        quoteCellsB.append(q83)
        quoteCellsB.append(q84)
        quoteCellsB.append(q85)
        quoteCellsB.append(q86)
        quoteCellsB.append(q87)
        quoteCellsB.append(q88)
        quoteCellsB.append(q89)
        quoteCellsB.append(q90)
        quoteCellsB.append(q91)
        quoteCellsB.append(q92)
        quoteCellsB.append(q93)
        quoteCellsB.append(q94)
        quoteCellsB.append(q95)
        quoteCellsB.append(q96)
        quoteCellsB.append(q97)
        quoteCellsB.append(q98)
        quoteCellsB.append(q99)
        quoteCellsB.append(q100)
        quoteCellsB.append(q101)
        quoteCellsB.append(q102)
        quoteCellsB.append(q103)
        quoteCellsB.append(q104)
        quoteCellsB.append(q105)
        quoteCellsB.append(q106)
        quoteCellsB.append(q107)
        quoteCellsB.append(q108)
        quoteCellsB.append(q109)
        quoteCellsB.append(q110)
        quoteCellsB.append(q111)
        quoteCellsB.append(q112)
        quoteCellsB.append(q113)
        quoteCellsB.append(q114)
        quoteCellsB.append(q115)
        quoteCellsB.append(q116)
        quoteCellsB.append(q117)
        quoteCellsB.append(q118)
        quoteCellsB.append(q119)
        quoteCellsB.append(q120)
        quoteCellsB.append(q121)
        quoteCellsB.append(q122)
        quoteCellsB.append(q123)
        quoteCellsB.append(q124)
        quoteCellsB.append(q125)
        quoteCellsB.append(q126)
        quoteCellsB.append(q127)
        quoteCellsB.append(q128)
        quoteCellsB.append(q129)
        quoteCellsB.append(q130)
        quoteCellsB.append(q131)
        quoteCellsB.append(q132)
        quoteCellsB.append(q133)
        quoteCellsB.append(q134)
        quoteCellsB.append(q135)
        quoteCellsB.append(q136)
        quoteCellsB.append(q137)
        quoteCellsB.append(q138)
        quoteCellsB.append(q139)
        quoteCellsB.append(q140)
        quoteCellsB.append(q141)
        quoteCellsB.append(q142)
        quoteCellsB.append(q143)
        quoteCellsB.append(q144)
        quoteCellsB.append(q145)
        quoteCellsB.append(q146)
        quoteCellsB.append(q147)
        quoteCellsB.append(q148)
        quoteCellsB.append(q149)
        quoteCellsB.append(q150)
        quoteCellsB.append(q151)
        quoteCellsB.append(q152)
        quoteCellsB.append(q153)
        quoteCellsB.append(q154)
        quoteCellsB.append(q155)
        quoteCellsB.append(q156)
        quoteCellsB.append(q157)
        quoteCellsB.append(q158)
        quoteCellsB.append(q159)
        quoteCellsB.append(q160)
        quoteCellsB.append(q161)
        quoteCellsB.append(q162)
        quoteCellsB.append(q163)
        quoteCellsB.append(q164)
        quoteCellsB.append(q165)
        quoteCellsB.append(q166)
        quoteCellsB.append(q167)
        quoteCellsB.append(q168)
        quoteCellsB.append(q169)
        quoteCellsB.append(q170)
        quoteCellsB.append(q171)
        quoteCellsB.append(q172)
        quoteCellsB.append(q173)
        quoteCellsB.append(q174)
        quoteCellsB.append(q175)
        quoteCellsB.append(q176)
        quoteCellsB.append(q177)
        quoteCellsB.append(q178)
        quoteCellsB.append(q179)
        quoteCellsB.append(q180)
        quoteCellsB.append(q181)
        quoteCellsB.append(q182)
        quoteCellsB.append(q183)
        quoteCellsB.append(q184)
        quoteCellsB.append(q185)
        quoteCellsB.append(q186)
        quoteCellsB.append(q187)
        quoteCellsB.append(q188)
        quoteCellsB.append(q189)
        quoteCellsB.append(q190)
        quoteCellsB.append(q191)
        quoteCellsB.append(q192)
        quoteCellsB.append(q193)
        quoteCellsB.append(q194)
        quoteCellsB.append(q195)
        quoteCellsB.append(q196)
        quoteCellsB.append(q197)
        quoteCellsB.append(q198)
        quoteCellsB.append(q199)
        quoteCellsB.append(q200)
        quoteCellsB.append(q201)
        quoteCellsB.append(q202)
        quoteCellsB.append(q203)
        quoteCellsB.append(q204)
        quoteCellsB.append(q205)
        quoteCellsB.append(q206)
        quoteCellsB.append(q207)
        quoteCellsB.append(q208)
        quoteCellsB.append(q209)
        quoteCellsB.append(q210)
        quoteCellsB.append(q211)
        quoteCellsB.append(q212)
        quoteCellsB.append(q213)
        quoteCellsB.append(q214)
        quoteCellsB.append(q215)
        quoteCellsB.append(q216)
        quoteCellsB.append(q217)
        quoteCellsB.append(q218)
        quoteCellsB.append(q219)
        quoteCellsB.append(q220)
        quoteCellsB.append(q221)
        quoteCellsB.append(q222)
        quoteCellsB.append(q223)
        quoteCellsB.append(q224)
        quoteCellsB.append(q225)
        quoteCellsB.append(q226)
        quoteCellsB.append(q227)
        quoteCellsB.append(q228)
        quoteCellsB.append(q229)
        quoteCellsB.append(q230)
        quoteCellsB.append(q231)
        quoteCellsB.append(q232)
        quoteCellsB.append(q233)
        quoteCellsB.append(q234)
        quoteCellsB.append(q235)
        quoteCellsB.append(q236)
        quoteCellsB.append(q237)
        quoteCellsB.append(q238)
        quoteCellsB.append(q239)
        quoteCellsB.append(q240)
        quoteCellsB.append(q241)
        quoteCellsB.append(q242)
        quoteCellsB.append(q243)
        quoteCellsB.append(q244)
        quoteCellsB.append(q245)
        quoteCellsB.append(q246)
        quoteCellsB.append(q247)
        quoteCellsB.append(q248)
        quoteCellsB.append(q249)
        quoteCellsB.append(q250)
        quoteCellsB.append(q251)
        quoteCellsB.append(q252)
        quoteCellsB.append(q253)
        quoteCellsB.append(q254)
        quoteCellsB.append(q255)
        quoteCellsB.append(q256)
        quoteCellsB.append(q257)
        quoteCellsB.append(q258)
        quoteCellsB.append(q259)
        quoteCellsB.append(q260)
        quoteCellsB.append(q261)
        quoteCellsB.append(q262)
        quoteCellsB.append(q263)
        quoteCellsB.append(q264)
        quoteCellsB.append(q265)
        quoteCellsB.append(q266)
        quoteCellsB.append(q267)
        quoteCellsB.append(q268)
        quoteCellsB.append(q269)
        quoteCellsB.append(q270)
        quoteCellsB.append(q271)
        quoteCellsB.append(q272)
        quoteCellsB.append(q273)
        quoteCellsB.append(q274)
        quoteCellsB.append(q275)
        quoteCellsB.append(q276)
        quoteCellsB.append(q277)
        quoteCellsB.append(q278)
        quoteCellsB.append(q279)
        quoteCellsB.append(q280)
        quoteCellsB.append(q281)
        quoteCellsB.append(q282)
        quoteCellsB.append(q283)
        quoteCellsB.append(q284)
        quoteCellsB.append(q285)
        quoteCellsB.append(q286)
        quoteCellsB.append(q287)
        quoteCellsB.append(q288)
        quoteCellsB.append(q289)
        quoteCellsB.append(q290)
        quoteCellsB.append(q291)
        quoteCellsB.append(q292)
        quoteCellsB.append(q293)
        quoteCellsB.append(q294)
        quoteCellsB.append(q295)
        quoteCellsB.append(q296)
        quoteCellsB.append(q297)
        quoteCellsB.append(q298)
        quoteCellsB.append(q299)
        quoteCellsB.append(q300)
        quoteCellsB.append(q301)
        quoteCellsB.append(q302)
        quoteCellsB.append(q303)
        quoteCellsB.append(q304)
        quoteCellsB.append(q305)
        quoteCellsB.append(q306)
        quoteCellsB.append(q307)
        quoteCellsB.append(q308)
        quoteCellsB.append(q309)
        quoteCellsB.append(q310)
        quoteCellsB.append(q311)
        quoteCellsB.append(q312)
        quoteCellsB.append(q313)
        quoteCellsB.append(q314)
        quoteCellsB.append(q315)
        quoteCellsB.append(q316)
        quoteCellsB.append(q317)
        quoteCellsB.append(q318)
        quoteCellsB.append(q319)
        
        
        var userDefaults = UserDefaults.standard
        
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: quoteCells)
        
        userDefaults.set(encodedData, forKey: "quoteCells")
        
        
        userDefaults.synchronize()
        
        if let data = userDefaults.data(forKey: "quoteCells"),
            let myArrayList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [QuoteClass] {
            myArrayList.forEach({print($0.key, $0.quote, $0.name, $0.like)})
        } else {
            print("B")
        }
        
        
        let encodedDataB: Data = NSKeyedArchiver.archivedData(withRootObject: quoteCellsB)
        
        userDefaults.set(encodedDataB, forKey: "quoteCellsB")
        
            userDefaults.synchronize()
        
        if let dataB = userDefaults.data(forKey: "quoteCellsB"),
            let myArrayListB = NSKeyedUnarchiver.unarchiveObject(with: dataB) as? [QuoteClass] {
            myArrayListB.forEach({print($0.key, $0.quote, $0.name, $0.like)})
        } else {
            print("B")
        }
        
    }
    
   
    
    @IBAction func xIconBtnPressed(_ sender: Any) {
        swipeCloseSwiped { (success) -> Void in
            if success {
                logoGoUp()
            }
        }
    }
    
    
    @IBAction func heartIconBtnPressed(_ sender: Any) {
        let selectedQuote = quoteCellsB[quoteKey]
        print(selectedQuote)
        if selectedQuote.like == 0 {
            selectedQuote.like = 1
            favoriteQuotes.append(selectedQuote)
            likedQuote()
        } else if selectedQuote.like == 1 {
            selectedQuote.like = 0
            unlikedQuote()
            print(selectedQuote.like)
        }
    
    }
    
    func likedQuote() {
        let image = UIImage(named: "heartLikeIcon")
        heartIcon.setImage(image, for: .normal)
        
        let likesData: Data = NSKeyedArchiver.archivedData(withRootObject: self.favoriteQuotes)
        
        UserDefaults.standard.set(likesData, forKey: "favoriteQuotes")
        
        
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.quoteCells)
        UserDefaults.standard.set(encodedData, forKey: "quoteCells")
        
        
        UserDefaults.standard.synchronize()
        
        if let data2 = UserDefaults.standard.data(forKey: "favoriteQuotes"),
            let myArrayList2 = NSKeyedUnarchiver.unarchiveObject(with: data2) as? [QuoteClass] {
            print("We have successfully saved to favorite quotes")
        } else {
            print("There was an issue")
        }
        
        if let data = UserDefaults.standard.data(forKey: "quoteCells"),
            let myArrayList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [QuoteClass] {
            myArrayList.forEach({print($0.key, $0.quote, $0.name, $0.like)})
        } else {
            print("There was an issue")
        }
        
    }
    
    
    func unlikedQuote() {
        let image = UIImage(named: "heartIcon")
        heartIcon.setImage(image, for: .normal)
        
        let likesData: Data = NSKeyedArchiver.archivedData(withRootObject: self.favoriteQuotes)
        
        UserDefaults.standard.set(likesData, forKey: "favoriteQuotes")
        
        UserDefaults.standard.synchronize()
        
        if let data2 = UserDefaults.standard.data(forKey: "favoriteQuotes"),
            let myArrayList2 = NSKeyedUnarchiver.unarchiveObject(with: data2) as? [QuoteClass] {
            myArrayList2.forEach({print($0.key, $0.quote, $0.name, $0.like)})
        } else {
            print("There was an issue")
        }
    }
    
    
    @IBAction func goToLikedQuotes(_ sender: Any) {
        print(quoteCells.count)
        performSegue(withIdentifier: "toLikedQuoteCells", sender: self)
    }
    
    
    @IBAction func goToVideos(_ sender: Any) {
        performSegue(withIdentifier: "goToVideos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LikesVC {
            destination.likedQuoteCells = favoriteQuotes
            destination.dailyDelivered2 = dailyDelivered
        } else {
            print("Data did not pass through correctly")
        }
    }
    
    
}

