//
//  SettingsView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/24/23.
//

import UIKit

class SettingsView: UIView {
    var defaults = UserDefaults.standard
    
    var labelElement: UILabel!
    var stackView: UIStackView!
    var notificationSwitch: UISwitch!
    var notificationTime: UIDatePicker!
    var testNotificationButton: UIButton!
    
    var stackBiometric: UIStackView!
    var labelBiometric: UILabel!
    var biometricSwitch: UISwitch!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupNotificationSettings()
        setupBiometricSettings()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Notification on or off, be sure to prompt user the first time they press it, or if not allowed in settings
    func setupNotificationSettings() {
        notificationSwitch = UISwitch()
        notificationSwitch.isOn = false
        
        labelElement = UILabel()
        labelElement.text = "Notifications"
        
        notificationTime = UIDatePicker()
        notificationTime.datePickerMode = .time
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if (defaults.object(forKey: "notificationHour") != nil) {
            dateComponents.hour = defaults.object(forKey: "notificationHour") as! Int?
        }
        else {
            dateComponents.hour = 9
        }
        if (defaults.object(forKey: "notificationMinute") != nil) {
            dateComponents.minute = defaults.object(forKey: "notificationMinute") as! Int?
        }
        else {
            dateComponents.minute = 0
        }
        
        notificationTime.date = calendar.date(from: dateComponents) ?? Date()
        notificationTime.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [notificationSwitch, labelElement, notificationTime])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        testNotificationButton = UIButton(type: .system)
        testNotificationButton.configuration = .filled()
        testNotificationButton.setTitle("Test Notification", for: .normal)

        testNotificationButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(testNotificationButton)
                
    }
    
    //FIXME: prompt user to allow access for touchID/FaceID in settings, remember setting. If false, send to login screen.
    func setupBiometricSettings() {
        labelBiometric = UILabel()
        labelBiometric.text = "Biometric login"
        
        biometricSwitch = UISwitch()
        biometricSwitch.isOn = false
        
        stackBiometric = UIStackView(arrangedSubviews: [biometricSwitch, labelBiometric])
        stackBiometric.axis = .horizontal
        stackBiometric.alignment = .center
        stackBiometric.spacing = 10
        stackBiometric.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackBiometric)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
                // StackView constraints
                stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                testNotificationButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
                testNotificationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                testNotificationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                stackBiometric.topAnchor.constraint(equalTo: testNotificationButton.bottomAnchor, constant: 20),
                stackBiometric.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stackBiometric.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ])
    }
    
    
}

