//
//  Person.swift
//  Wookieepedia
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class Person: Entity{
    
    let height: String
    let mass: String
    let gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles: [String]
    let starships: [String]
   
    init?(with dictionary: [String : Any]){
        guard let name = dictionary["name"] as? String,
            let height = dictionary["height"] as? String,
            let mass = dictionary["mass"] as? String,
            let gender = dictionary["gender"] as? String,
            let homeworld = dictionary["homeworld"] as? String,
            let films = dictionary["films"] as? [String],
            let species = dictionary["species"] as? [String],
            let vehicles = dictionary["vehicles"] as? [String],
            let starships = dictionary["starships"] as? [String] else {return nil}
        
        self.height = height
        self.mass = mass
        self.gender = gender
        self.homeworld = homeworld
        self.films = films
        self.species = species
        self.vehicles = vehicles
        self.starships = starships
        
        super.init(name: name)
    }
}
