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
    
    var stackDelete: UIStackView!
    var deleteLabel: UILabel!
    var deleteSwitch: UISwitch!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemBackground
        setupNotificationSettings()
        setupBiometricSettings()
        setupDeleteSettings()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Notification on or off, be sure to prompt user the first time they press it, or if not allowed in settings
    func setupNotificationSettings() {
        notificationSwitch = UISwitch()
        notificationSwitch.onTintColor = .orange
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
        testNotificationButton.tintColor = .orange
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
        biometricSwitch.onTintColor = .orange
        biometricSwitch.isOn = false
        
        stackBiometric = UIStackView(arrangedSubviews: [biometricSwitch, labelBiometric])
        stackBiometric.axis = .horizontal
        stackBiometric.alignment = .center
        stackBiometric.spacing = 10
        stackBiometric.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackBiometric)
    }
    
    func setupDeleteSettings() {
        deleteLabel = UILabel()
        deleteLabel.text = "Delete note confirmation"
        
        deleteSwitch = UISwitch()
        deleteSwitch.onTintColor = .orange
        deleteSwitch.isOn = true
        
        stackDelete = UIStackView(arrangedSubviews: [deleteSwitch, deleteLabel])
        stackDelete.axis = .horizontal
        stackDelete.alignment = .center
        stackDelete.spacing = 10
        stackDelete.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackDelete)
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
                stackDelete.topAnchor.constraint(equalTo: stackBiometric.bottomAnchor, constant: 20),
                stackDelete.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stackDelete.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ])
    }
    
    
}

