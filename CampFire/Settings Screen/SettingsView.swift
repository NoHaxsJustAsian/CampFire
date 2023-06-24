//
//  SettingsView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/24/23.
//

import UIKit

class SettingsView: UIView {
    
    var labelElement: UILabel!
    var stackView: UIStackView!
    var notificationSwitch: UISwitch!
    var notificationTime: UIDatePicker!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = .white
        setupNotificationSettings()
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
        self.addSubview(notificationTime)
        notificationTime.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [notificationSwitch, labelElement,notificationTime])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
    }
    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
                // StackView constraints
                stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ])
    }
    
    
}

