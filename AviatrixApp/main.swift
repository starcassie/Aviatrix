//
//  main.swift
//  AviatrixApp
//
//  Created by Amy Holt on 6/10/18.
//  Copyright © 2018 Amy Holt. All rights reserved.
//

import Foundation

func gauges(myPlane : Aviatrix) {
    print("Reading the gauges...")
    print(" ")
    print("| Running:  | ✅")
    print("| Location:  | \(myPlane.location)")
    print("| Distance:  | \(myPlane.distanceTraveled) miles")
    print("| Fuel:      | \(myPlane.fuelLevel) gallons")
    print("| Max Fuel:  | \(myPlane.maxFuel) gallons")
    print("| MPG:       | \(myPlane.milesPerGallon)")
    print("| Fuel Bill: | \(myPlane.fuelCost)")
}

func fuelCheck(myPlane : Aviatrix, destination : String) -> Bool {
    let distanceToTravel =  Double(myPlane.distanceTo(loc: myPlane.location, target : destination))
    if myPlane.fuelLevel < distanceToTravel {
        print(" ")
        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
        print("Oh no! You've run out of fuel and crashed on the way to \(myPlane.location)!")
        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
        command = "q"
        return false
    } else {
        return true
    }
}

func fly(myPlane : Aviatrix) {
    print("Where would you like to fly to? ")
    print(" ")
    let destinations = myPlane.knownDestinations()
    var destinationsOrder = [String]()
    for (_, city) in destinations.enumerated() {
        let distance = myPlane.distanceTo(loc: myPlane.location, target: city)
        if (!destinationsOrder.isEmpty) {
            for index in 0..<destinationsOrder.count {
                if(distance < myPlane.distanceTo(loc: myPlane.location, target: destinationsOrder[index])) {
                    destinationsOrder.insert(city, at: index)
                    break
                } else if (index == destinationsOrder.count - 1) {
                    destinationsOrder.append(city)
                }
            }
        } else {
            destinationsOrder.append(city)
        }
    }
    for (index, city) in destinationsOrder.enumerated() {
        let distance = myPlane.distanceTo(loc: myPlane.location, target: city)
        print("\(index): \(city), (\(distance) miles)")
    }
    
    let response = Int(readLine()!)
    var desiredLocation = ""
    
    if response! >= 0 && response! < destinationsOrder.count {
        desiredLocation = destinationsOrder[response!]
        print("🛫 Preparing for takeoff...")
        print("🛫 Flying...")
        
        if fuelCheck(myPlane: myPlane, destination : desiredLocation) {
            myPlane.flyTo(destination: desiredLocation)
            print("🛬 You've arrived in \(myPlane.location)!")
            gauges(myPlane: myPlane)
        }
    }
    else {
        print("⚠️Please enter a valid command⚠️")
    }
    
}

func refuel(myPlane : Aviatrix) {
    var price = 0.0
    let fuelAdded = Double(myPlane.maxFuel) - myPlane.fuelLevel
    for city in myPlane.data.fuelPrices {
        if (myPlane.location == city.key) {
            price = city.value
        }
    }
    let cost = fuelAdded * price
    myPlane.refuel(cost: cost)
    print("Refueling...")
    print("⛽ Here in \(myPlane.location), jet fuel costs \(price)")
    print("⛽ You refueled \(fuelAdded) gallons totaling \(cost)")
}

var command = ""

//func fuelCheck(myPlane : Aviatrix, destination : String) -> Bool {
//    let distanceToTravel =  Double(myPlane.distanceTo(loc: myPlane.location, target : destination))
//    if myPlane.fuelLevel < distanceToTravel {
//        print(" ")
//        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
//        print("Oh no! You've run out of fuel and crashed on the way to \(myPlane.location)!")
//        print("🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥 🔥")
//        command = "q"
//        return false
//    } else {
//        return true
//    }
//}

var plane = Aviatrix(name: "Cassie Areff")

print("Welcome to the Aviatrix Flight System by \(plane.author)")
plane.start()

print("You're currently in _________")


while command != "q" {
    print(" ")
    print("What would you like to do?")
    print("a) 📊 check the plane gauges")
    print("b) 🛫 fly to a different city")
    print("c) ⛽ refuel")
    print("q) ❌ quit")
    print(" ")
    print("Action: ")
    command = readLine()!
    
    if command == "a" {
        gauges(myPlane: plane)
    }
    else if command == "b" {
        fly(myPlane: plane)
    }
    else if command == "c" {
        refuel(myPlane: plane)
    }
    else if command != "q" {
        print("⚠️Please enter a valid command⚠️")
    }
}

print(" ")
print("Thanks for flying with \(plane.author)'s very profesional airline!")
