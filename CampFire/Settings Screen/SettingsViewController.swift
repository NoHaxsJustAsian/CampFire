//
//  SettingsViewController.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/24/23.
//

import UIKit
import UserNotifications
import LocalAuthentication

class SettingsViewController: UIViewController {

    let settingsView = SettingsView()
    var hour:Int?
    var minute:Int?
    var notificationSwitchOn:Bool?
    var biometricSwitchOn:Bool?
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = settingsView
        checkForNotificationPermission()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        title = "Settings"
        settingsView.notificationTime.addTarget(self, action: #selector(notificationTimeValueChanged(_:)), for: .valueChanged)
        settingsView.notificationSwitch.addTarget(self, action: #selector(notificationSwitchValueChanged(_:)), for: .valueChanged)
        settingsView.testNotificationButton.addTarget(self, action: #selector(sendTestNotification), for: .touchUpInside)
        settingsView.biometricSwitch.addTarget(self, action: #selector(biometricSwitchValueChanged(_:)), for: .valueChanged)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Allow biometrics to login"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if success {
                        self.settingsView.biometricSwitch.isOn = true
                        self.defaults.set(true, forKey: "biometricSwitch")
                    } else {
                        self.showAlert(title: "Error!", message: "Biometric check failed. Try again.")
                        self.settingsView.biometricSwitch.isOn = false
                        self.defaults.set(false, forKey: "biometricSwitch")
                    }
                }
            }
        } else {
            self.showAlert(title: "Error!", message: "This device does not support biometrics")
            self.settingsView.biometricSwitch.isOn = false
            self.defaults.set(false, forKey: "biometricSwitch")
        }
    }
    
    func checkForNotificationPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options:[.alert, .badge, .sound]) { didAllow, error in
                    if didAllow {
                        if self.notificationSwitchOn! {
                            self.dispatchNotification()
                        }
                    }
                }
            default:
                return
            }
        }
    }
    
    func loadDefaults(){
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if (defaults.object(forKey: "notificationHour") != nil) {
            hour = defaults.object(forKey: "notificationHour") as! Int?
            dateComponents.hour = hour
        }
        if (defaults.object(forKey: "notificationMinute") != nil) {
            minute = defaults.object(forKey: "notificationMinute") as! Int?
            dateComponents.minute = minute
            settingsView.notificationTime.date = calendar.date(from: dateComponents) ?? Date()
        }
        
        if (defaults.object(forKey: "notificationSwitch") != nil) {
            notificationSwitchOn = defaults.object(forKey: "notificationSwitch") as? Bool
            settingsView.notificationSwitch.isOn = defaults.object(forKey: "notificationSwitch") as! Bool
        }
        
        if (defaults.object(forKey: "biometricSwitch") != nil) {
            biometricSwitchOn = defaults.object(forKey: "biometricSwitch") as? Bool
            settingsView.biometricSwitch.isOn = defaults.object(forKey: "biometricSwitch") as! Bool
        }


    }
    
    func dispatchNotification() {
        let identifier = "reflectionTime"
        let title = "CampFire"
        let hour = hour
        let minute = minute
        let body = "Time for your daily reflection!"
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request)
    }
    
    @objc func notificationTimeValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        let selectedTime = dateFormatter.string(from: sender.date)

        let date = dateFormatter.date(from: selectedTime) ?? Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)

        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        defaults.set(hour, forKey: "notificationHour")
        defaults.set(minute, forKey: "notificationMinute")
    }
    
    @objc func notificationSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            // Enable notifications
            defaults.set(true, forKey: "notificationSwitch")
        } else {
            let identifier = "reflectionTime"
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
            defaults.set(false, forKey: "notificationSwitch")
        }
        if self.notificationSwitchOn! {
            self.dispatchNotification()
        }
    }
    
    @objc func biometricSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            authenticate()
        } else {
            defaults.set(false, forKey: "biometricSwitch")
        }
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "CampFire"
        content.body = "Test notification for your daily reflection!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: content, trigger: trigger)
        
        if notificationSwitchOn! {
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error sending test notification: \(error.localizedDescription)")
                    self.showAlert(title:"Error!", message:"Notifications are off in settings!")
                } else {
                    print("Test notification sent successfully.") //change this to system notification.
                }
            }
        }
        else {
            showAlert(title:"Error!", message:"Notification switch is off!")
        }
    }
}
