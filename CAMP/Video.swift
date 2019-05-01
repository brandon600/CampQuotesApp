//
//  Video.swift
//  CAMP
//
//  Created by BRANDON RODRIGUEZ on 6/30/18.
//  Copyright © 2018 BRodz. All rights reserved.
//

import Foundation


class Video {
    private var _title: String!
    private var _embedLink: String!
    private var _person: String!
    private var _link: String!
    
    var title: String {
        return _title
    }
    
    var embedLink: String {
        return _embedLink
    }
    
    var person: String {
        return _person 
    }
    
    var link: String {
        return _link
    }
    
    init(title: String, embedLink: String, person: String, link: String) {
        _title = title
        _embedLink = embedLink
        _person = person
        _link = link
    }
}
