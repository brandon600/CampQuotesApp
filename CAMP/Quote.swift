//
//  Quote.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 3/14/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import Foundation


class QuoteClass: NSObject, NSCoding {
    private var _key: Int!
    private var _quote: String!
    private var _name: String!
    private var _like: Int!
    
    var key: Int {
        return _key
    }
    
    var quote: String {
        return _quote
    }
    
    var name: String {
        return _name
    }
    
    var like: Int {
        get {
        return _like
        } set {
            _like = newValue
        }
    }
    
    init(key: Int, quote: String, name: String, like: Int) {
        _key = key
        _quote = quote
        _name = name
        _like = like
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let key = aDecoder.decodeInteger(forKey: "key")
        let quote = aDecoder.decodeObject(forKey: "quote") as! String
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let like = aDecoder.decodeInteger(forKey: "like")
        self.init(key: key, quote: quote, name: name, like: like)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "key")
        aCoder.encode(quote, forKey: "quote")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(like, forKey: "like")
    }
}
