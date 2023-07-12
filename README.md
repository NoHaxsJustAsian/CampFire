# CampFire - iOS To-Do App
NEU iOS App Development CS4520
![CampFire Logo](CampFire/Assets.xcassets/campfire.imageset/icons8-campfire-100.png)

CampFire is an intuitive iOS app designed to help you stay organized and manage your daily tasks effectively. With its user-friendly interface and powerful features, CampFire aims to enhance your productivity and keep you on track with your goals. This README provides an overview of CampFire, its key features, and instructions for installation and usage.

## Features

### Biometric Authentication
CampFire provides a secure login experience by integrating with iOS biometric authentication systems. You can conveniently log in to the app using your device's fingerprint or facial recognition, ensuring that only authorized individuals have access to your tasks and information.

### Task Management
With CampFire, you can create and manage your to-do lists effortlessly. The app allows you to:
- Add tasks: Create new tasks with titles and descriptions.
- Organize tasks by days: Group tasks into different days of the week using tabs, making it easy to focus on tasks for each specific day.
- Swipe left to complete: Mark tasks as complete by swiping left on them.
- Swipe right to move tasks: Move tasks to another day by swiping right on them.

### End-of-Day Review
CampFire encourages reflection and self-improvement by prompting you to review your missed tasks at the end of each day. By providing you with a summary of tasks you didn't accomplish, the app helps you evaluate your productivity and identify areas for improvement. This feature empowers you to prioritize effectively and ensure that essential tasks are completed.

### Notification Reminder
CampFire provides a notification reminder feature specifically for the end-of-day review. You can set a preferred time for CampFire to remind you to review your missed tasks. This notification reminder ensures that you don't forget to reflect on your productivity and address any pending tasks before starting a new day.

### Multiple User Accounts
CampFire supports multiple user accounts, allowing different individuals to create their personalized task lists within the app. Each user can have their own set of tasks, priorities, and notifications. This feature enables seamless task management for individuals, families, or teams sharing a device.

### Firebase Integration
CampFire leverages Firebase services for seamless authentication, data storage, and user management. Firebase Authentication ensures a secure login process, while Firebase Cloud Firestore allows for real-time data synchronization across multiple devices. These integrations enable you to access your tasks from anywhere and have a consistent experience across devices.

### User-Friendly Interface
CampFire is designed to be intuitive and user-friendly. Its clean and minimalistic interface allows for easy navigation and seamless task management. The app's layout emphasizes readability, enabling you to focus on your tasks without unnecessary distractions.

## Installation

As CampFire is not available on the App Store, you will need to follow these steps to install it on your iOS device:

1. Clone or download the CampFire repository from [GitHub](https://github.com/NoHaxsJustAsian/CampFire).
2. Open the project in Xcode by double-clicking the `CampFire.xcodeproj` file.
3. Ensure you have CocoaPods installed on your system. If not, install it by running `sudo gem install cocoapods` in your terminal.
4. In the project directory, run `pod install` to install the required dependencies.
5. Open the `CampFire.xcworkspace` file in Xcode.
6. Connect your iOS device to your computer and select it as the build target.
7. Click the "Run" button in Xcode to build and install CampFire on your device.
8. On your iOS device, go to Settings > General > Device Management and trust the developer certificate for the CampFire app.

Note: Installing apps from outside the App Store may require you to adjust your device's settings to allow installations from unknown sources. Please consult your device's documentation for more information.

## Usage

Upon launching CampFire, you will be presented with the login screen. Use your device's biometric authentication system (fingerprint or facial recognition) to log in securely. If you prefer, you can also choose to log in using a traditional username and password.

After logging in, you will enter the main screen of CampFire. Here, you can explore the app's features and manage your tasks:
- To create a new task, tap the "+" button or the "Add Task" option. Fill in the task details.
- Organize tasks by days: Use the tabs representing each day of the week to group tasks accordingly. Switch between tabs to focus on tasks for each specific day.
- Swipe left to complete: Mark tasks as complete by swiping left on them.
- Swipe right to move tasks: Move tasks to another day by swiping right on them.
- CampFire will remind you to review your missed tasks at the end of the day. Set a preferred time for this notification reminder in the app's settings or preferences.

## Feedback and Support

We value your feedback and are committed to providing the best user experience possible. If you encounter any issues, have suggestions for improvement, or need assistance, please reach out to our support team at support@campfireapp.com. We appreciate your input and will strive to address your concerns promptly.

## License

CampFire is available under the [MIT License](https://opensource.org/licenses/MIT). Feel free to modify and distribute the app in accordance with the license terms.

## Acknowledgment

[iOSNU](https://iosnu.sakibnm.space/)

Thank you for choosing CampFire! We hope this app helps you organize your tasks efficiently and achieve your goals.
