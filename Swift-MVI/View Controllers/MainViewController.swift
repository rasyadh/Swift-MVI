//
//  MainViewController.swift
//  Swift-MVI
//
//  Created by Rasyadh Abdul Aziz on 17/08/20.
//  Copyright © 2020 Rasyadh Abdul Aziz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var damageProgress: UIProgressView!
    @IBOutlet weak var fireRateProgress: UIProgressView!
    @IBOutlet weak var accuracyProgress: UIProgressView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    
    // MARK: Properties
    private let intent = MainIntent()
    private let disposeBag = DisposeBag()
    
    var selectedAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindButtons()
        intent.bind(toView: self)
        setupSelectionAlert()
    }
    
    public func update(withState state: WeaponState) {
        switch state {
        case is WeaponPresenting:
            let weaponState = state as! WeaponPresenting
            showPresentState(withPresentState: weaponState)
            break
        case is WeaponSelected:
            let weaponState = state as! WeaponSelected
            showSelectedState(withWeaponName: weaponState.weapon.name)
            break
        default:
            break
        }
    }
    
    private func showPresentState(withPresentState state: WeaponPresenting) {
        let weapon = state.weapon
        nameLabel.text = weapon.name
        imageView.image = UIImage(named: weapon.name)
        damageProgress.progress = Float(weapon.damage) / 100
        fireRateProgress.progress = Float(weapon.fireRate) / 100
        accuracyProgress.progress = Float(weapon.accuracy) / 100
        
        previousButton.isEnabled = state.previousAvailable
        nextButton.isEnabled = state.nextAvailable
    }
    
    private func showSelectedState(withWeaponName name: String) {
        guard let alert = selectedAlert else { return }
        alert.message = name
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: Methods
    private func bindButtons() {
        previousButton.rx.tap.bind {
            self.intent.onPreviousWeaponTapped()
        }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind {
            self.intent.onNextWeaponTapped()
        }.disposed(by: disposeBag)
        
        selectButton.rx.tap.bind {
            self.intent.onSelectWeapon()
        }.disposed(by: disposeBag)
    }
    
    private func setupSelectionAlert() {
        selectedAlert = UIAlertController(
            title: "Weapon Selected",
            message: "",
            preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            self.intent.onDismissWeapon()
        }
        selectedAlert?.addAction(dismiss)
    }
}
