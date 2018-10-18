//
//  SwapiClient.swift
//  Wookiepedia2.0
//
//  Created by DevMountain on 9/26/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import Foundation

class SwapiClient{
    
    static let shared = SwapiClient()
    private init(){}
    
    let baseURL = URL(string: "https://swapi.co/api/")
    
    var nextPageUrlString: String?
    var previousPageUrlString: String?
    var resultCount: Int?
    
    
    func fetchAllCategories(completion: @escaping ([CategoryContainer]?) -> Void){
        guard let url = baseURL else {return}
        
        print(url.absoluteString)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            
            print(response ?? "👽 There was no response 👽")
            
            guard let data = data else {completion(nil) ; return}
            
            do{
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : String] else {return}
                
                var categoryDictionaries: [[Category : String]] = []
                
                for (key, value) in dictionary{
                    guard let category = Category(rawValue: key) else {return}
                    let categoryDictionary = [category : value]
                    categoryDictionaries.append(categoryDictionary)
                }
                
                completion(categoryDictionaries)
            } catch{
                print("💩  There was an error in \(#function) ; \(error)  ; \(error.localizedDescription)  💩")
            }
            
            
            }.resume()
    }
    
    
    func fetchEntities(for category: CategoryContainer, completion: @escaping ([Entity]?) -> ()){
        
        guard let urlString = category.values.first else {return}
        
        print(urlString)
        
        fetchEntityfor(urlString: urlString, category: category) { (entities) in
            completion(entities)
        }
    }
    
    func fetchEntityfor(urlString: String, category: CategoryContainer, completion: @escaping ([Entity]?) -> Void){
        
        guard let url = URL(string: urlString) else {completion(nil) ; return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error{
                print("\(error.localizedDescription) \(error) in function: \(#function)")
                completion(nil)
                return
            }
            
            print(response ?? "👽 There was no response 👽")
            
            guard let data = data else {completion(nil) ; return}
            
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
                self.nextPageUrlString = jsonDictionary?["next"] as? String
                self.previousPageUrlString = jsonDictionary?["previous"] as? String
                self.resultCount = jsonDictionary?["count"] as? Int
                guard let entityDictionaries = jsonDictionary?["results"] as? [[String : Any]] else {return}
                
                var entities: [Entity] = []
                
                for dictionary in entityDictionaries{
                    guard let entity = self.initEntityFor(category: category, with: dictionary) else {return}
                    entities.append(entity)
                }
                completion(entities)
                
            }catch {
                print("There was as error in \(#function) :  \(error) \(error.localizedDescription)")
                completion(nil)
                return
            }
            }.resume()
    }
    
    func initEntityFor(category: CategoryContainer, with dictionary: [String : Any]) -> Entity?{
        
        guard let category = category.keys.first else {return nil}
        
        switch category{
        case .Person:
            return Person(with: dictionary)
        case .Film:
            return Film(with: dictionary)
        case .Specie:
            return Species(dictionary: dictionary)
        case .Starship:
            return Starship(with: dictionary)
        case .Vehicle:
            return Vehicle(with: dictionary)
        case .Planet:
            return Planet(with: dictionary)
        }
        
    }
    
}


