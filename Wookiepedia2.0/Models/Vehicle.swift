//
//  Vehicle.swift
//  Wookieepedia
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class Vehicle: Entity{
    
    let model: String
    let manufacturer: String
    let cost: String
    let crew: String
    let passengers: String
    let vehicleClass: String
    let pilots: [String]
    let films: [String]
    
    init?(with dictionary: [String: Any]){
        guard let name = dictionary["name"] as? String,
            let model = dictionary["model"] as? String,
            let manufacturer = dictionary["manufacturer"] as? String,
            let cost = dictionary["cost_in_credits"] as? String,
            let crew = dictionary["crew"] as? String,
            let passengers = dictionary["passengers"] as? String,
            let vehicleClass = dictionary["vehicle_class"] as? String,
            let pilots = dictionary["pilots"] as? [String],
            let films = dictionary["films"] as? [String] else {return nil}
        
        self.model = model
        self.manufacturer = manufacturer
        self.cost = cost
        self.crew = crew
        self.passengers = passengers
        self.vehicleClass = vehicleClass
        self.pilots = pilots
        self.films = films
        
        super.init(name: name)
    }
}
