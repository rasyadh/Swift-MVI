//
//  WeaponSelector.swift
//  Swift-MVI
//
//  Created by Rasyadh Abdul Aziz on 17/08/20.
//  Copyright © 2020 Rasyadh Abdul Aziz. All rights reserved.
//

import Foundation

class WeaponSelector {
    // MARK: State
    let weapons: [Weapon]
    var weaponId: Int = 0
    
    // MARK: Properties
    var previousWeapon: Weapon? { return getPreviousWeapon() }
    var nextWeapon: Weapon? { return getNextWeapon() }
    var currentWeapon: Weapon { return weapons[weaponId] }
    
    init() {
        weapons = [
            Weapon("QQ9", 40, 83, 38),
            Weapon("Cordite", 39, 80, 47),
            Weapon("MSMC", 40, 92, 37),
            Weapon("PDW-57", 42, 75, 49)
        ]
    }
    
    public func isPreviousWeaponAvailable() -> Bool {
        return weaponId > 0
    }
    
    public func isNextWeaponAvailable() -> Bool {
        return weapons.count - 1 > weaponId
    }
    
    private func getPreviousWeapon() -> Weapon? {
        if !isPreviousWeaponAvailable() { return nil }
        weaponId -= 1
        return weapons[weaponId]
    }
    
    private func getNextWeapon() -> Weapon? {
        if !isNextWeaponAvailable() { return nil }
        weaponId += 1
        return weapons[weaponId]
    }
}
