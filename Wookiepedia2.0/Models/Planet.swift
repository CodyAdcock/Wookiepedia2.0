//
//  Planet.swift
//  Wookieepedia
//
//  Created by DevMountain on 9/18/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class Planet: Entity{
    
    let climate: String
    let gravity: String
    let terrain: String
    let population: String
    let residentUrls: [String]
    let filmUrls: [String]
    
    init?(with dictionary: [String : Any]){
        
        guard let name = dictionary["name"] as? String,
            let climate = dictionary["climate"] as? String,
            let gravity = dictionary["gravity"] as? String,
            let terrain = dictionary["terrain"] as? String,
            let population = dictionary["population"] as? String,
            let residentUrls = dictionary["residents"] as? [String],
            let filmUrls = dictionary["films"] as? [String] else {return nil}
        
        self.climate = climate
        self.gravity = gravity
        self.terrain = terrain
        self.population = population
        self.residentUrls = residentUrls
        self.filmUrls = filmUrls
        super.init(name: name)
    }
}
