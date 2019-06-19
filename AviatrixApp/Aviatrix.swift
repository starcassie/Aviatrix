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
    var maxFuel: Int
    var fuelLevel: Double
    var milesPerGallon: Double
    var fuelCost: Double
    
    // initializer
    init(name: String) {
        author = name
        data = AviatrixData()
        location = "St. Louis"
        distanceTraveled = 0
        maxFuel = 5000
        fuelLevel = 5000
        milesPerGallon = 0.4
        fuelCost = 0
    }
    
    func start() -> Bool {
        running = true
        return (running)
    }
    
    func refuel(cost: Double) {
        fuelCost += cost
    }
    
    func flyTo(destination : String) {
        distanceTraveled += distanceTo(loc: location, target: destination)
        milesPerGallon = 0.55 - (fuelLevel) * (0.00005)
        fuelLevel -= Double(distanceTo(loc: location, target: destination)) * milesPerGallon
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
