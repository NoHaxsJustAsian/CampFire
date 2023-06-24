//
//  SettingsViewController.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/24/23.
//

import UIKit

class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
