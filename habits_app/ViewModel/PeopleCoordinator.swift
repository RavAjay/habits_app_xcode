//
//  Sorter.swift
//  habits_app
//
//  Created by Home PC on 2/13/25.
//

import Foundation

class PeopleCoordinator {
    
    var people = [Person]()
    
    //Server
    func getPeopleInformatiom() {
        var p1 = Person(name: "John", age: 25)
        var p2 = Person(name: "Jane", age: 22)
        var p3 = Person(name: "Jim", age: 27)
        var p4 = Person(name: "Adam", age: 26)
        var p5 = Person(name: "Sheldon", age: 23)
        self.people = [p1, p2, p3, p4, p5]
    }
    
}
