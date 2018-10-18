//
//  Species.swift
//  Wookieepedia
//
//  Created by DevMountain on 9/18/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class Species: Entity{
    
    let classification: String
    let designation: String
    let averageHeight: String
    let averageLifespan: String
    let homeworld: String
    let language: String
    let poeple: [String]
    let films: [String]
    
    init?(dictionary: [String : Any]){
        guard let name = dictionary["name"] as? String,
            let classification = dictionary["classification"] as? String,
            let designation = dictionary["designation"] as? String,
            let averageHeight = dictionary["average_height"] as? String,
            let averageLifespan = dictionary["average_lifespan"] as? String,
            let homeworld = dictionary["homeworld"] as? String,
            let language = dictionary["language"] as? String,
            let people = dictionary["people"] as? [String],
            let films = dictionary["films"] as? [String] else {return nil}
        
        
        self.classification = classification
        self.designation = designation
        self.averageHeight = averageHeight
        self.averageLifespan = averageLifespan
        self.homeworld = homeworld
        self.language = language
        self.poeple = people
        self.films = films
        
        super.init(name: name)
    }
}
