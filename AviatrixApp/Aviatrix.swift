//
//  Aviatrix.swift
//  AviatrixApp
//
//  Created by Amy Holt on 6/10/18.
//  Copyright © 2018 Amy Holt. All rights reserved.
//

import Foundation

class Aviatrix {
    
    // holds author
    var author: String
    var running = false
    var data: AviatrixData
    var location: String
    var distanceTraveled: Int
    
    // initializer
    init(name: String) {
        author = name
        data = AviatrixData()
        location = "St. Louis"
        distanceTraveled = 0
    }
    
    func start() -> Bool {
        running = true
        return (running)
    }
    
    func refuel() {
        
    }
    
    func flyTo(destination : String) {
        location = destination
    }
    
    func distanceTo(loc: String, target : String) -> Int{
        return(data.knownDistances[loc]![target]!)
    }
    
    func knownDestinations() -> [String] {
        var places = [String]()
        for city in data.knownDistances {
            places.append(city.key)
        }
       return (places)
    }
}
