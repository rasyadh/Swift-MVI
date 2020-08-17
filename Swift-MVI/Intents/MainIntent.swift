//
//  MainIntent.swift
//  Swift-MVI
//
//  Created by Rasyadh Abdul Aziz on 17/08/20.
//  Copyright © 2020 Rasyadh Abdul Aziz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainIntent {
    var stateRelay: PublishRelay<WeaponState>
    var view: MainViewController?
    let weaponSelector = WeaponSelector()
    var disposeBag = DisposeBag()
    
    init() {
        stateRelay = PublishRelay()
    }
    
    public func bind(toView view: MainViewController) {
        self.view = view
        
        stateRelay.subscribe { event in
            guard let state = event.element else { return }
            self.view?.update(withState: state)
        }.disposed(by: disposeBag)
        
        let weapon = weaponSelector.currentWeapon
        let previous = weaponSelector.isPreviousWeaponAvailable()
        let next = weaponSelector.isNextWeaponAvailable()
        
        stateRelay.accept(WeaponPresenting(
            withWeapon: weapon,
            previousAvailable: previous,
            nextAvailable: next))
    }
    
    public func onPreviousWeaponTapped() {
        guard let weapon = weaponSelector.previousWeapon else { return }
        presentWeapon(weapon)
    }
    
    public func onNextWeaponTapped() {
        guard let weapon = weaponSelector.nextWeapon else { return }
        presentWeapon(weapon)
    }
    
    public func onSelectWeapon() {
        stateRelay.accept(WeaponSelected(selectedWeapon: weaponSelector.currentWeapon))
    }
    
    public func onDismissWeapon() {
        presentWeapon(weaponSelector.currentWeapon)
    }
    
    private func presentWeapon(_ weapon: Weapon) {
        let previous = weaponSelector.isPreviousWeaponAvailable()
        let next = weaponSelector.isNextWeaponAvailable()
        stateRelay.accept(WeaponPresenting(
            withWeapon: weapon,
            previousAvailable: previous,
            nextAvailable: next))
    }
}
