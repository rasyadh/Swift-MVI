//
//  Weapon.swift
//  Swift-MVI
//
//  Created by Rasyadh Abdul Aziz on 17/08/20.
//  Copyright © 2020 Rasyadh Abdul Aziz. All rights reserved.
//

import Foundation

class Weapon: Codable {
    let name: String
    let damage: Int
    let fireRate: Int
    let accuracy: Int
    
    init(_ name: String, _ damage: Int, _ fireRate: Int, _ accuracy: Int) {
        self.name = name
        self.damage = damage
        self.fireRate = fireRate
        self.accuracy = accuracy
    }
}
