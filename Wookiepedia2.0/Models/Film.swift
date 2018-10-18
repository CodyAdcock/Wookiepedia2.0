//
//  Film.swift
//  Wookieepedia
//
//  Created by DevMountain on 9/18/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class Film: Entity{
    
    let episodeNumber: Int
    let openingText: String
    let director: String
    let producer: String
    let releaseDate: String
    let characters: [String]
    let planets: [String]
    let vehicles: [String]
    let species: [String]
    
    init?(with dictionary: [String : Any]){
        guard let title = dictionary["title"] as? String,
        let episodeNumber = dictionary["episode_id"] as? Int,
        let openingText = dictionary["opening_crawl"] as? String,
        let director = dictionary["director"] as? String,
        let producer = dictionary["producer"] as? String,
        let releaseDate = dictionary["release_date"] as? String,
        let characters = dictionary["characters"] as? [String],
        let planets = dictionary["planets"] as? [String],
        let vehicles = dictionary["vehicles"] as? [String],
            let species = dictionary["species"] as? [String] else {return nil}
        
        self.episodeNumber = episodeNumber
        self.openingText = openingText
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.characters = characters
        self.planets = planets
        self.vehicles = vehicles
        self.species = species
        
        super.init(name: title)
    }
}
