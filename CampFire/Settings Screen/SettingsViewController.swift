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
        title = "Settings"
        settingsView.notificationTime.addTarget(self, action: #selector(notificationTimeValueChanged(_:)), for: .valueChanged)
        settingsView.notificationSwitch.addTarget(self, action: #selector(notificationSwitchValueChanged(_:)), for: .valueChanged)
        settingsView.testNotificationButton.addTarget(self, action: #selector(sendTestNotification), for: .touchUpInside)
    }

    @objc func notificationTimeValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let selectedTime = dateFormatter.string(from: sender.date)
        print(selectedTime) //FIXME: change this to store time of notification
    }
    
    @objc func notificationSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            // Enable notifications
        } else {
            // Disable notifications
        }
    }
    
    @objc func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error sending test notification: \(error.localizedDescription)")
            } else {
                print("Test notification sent successfully.") //change this to system notification.
            }
        }
    }
}
