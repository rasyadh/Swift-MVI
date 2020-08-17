//
//  WeaponState.swift
//  Swift-MVI
//
//  Created by Rasyadh Abdul Aziz on 17/08/20.
//  Copyright © 2020 Rasyadh Abdul Aziz. All rights reserved.
//

import Foundation

protocol WeaponState {}

class WeaponPresenting: WeaponState {
    let weapon: Weapon
    let previousAvailable: Bool
    let nextAvailable: Bool
    
    init(withWeapon weapon: Weapon, previousAvailable previous: Bool, nextAvailable next: Bool) {
        self.weapon = weapon
        self.previousAvailable = previous
        self.nextAvailable = next
    }
}

class WeaponSelected: WeaponState {
    let weapon: Weapon
    
    init(selectedWeapon weapon: Weapon) {
        self.weapon = weapon
    }
}
