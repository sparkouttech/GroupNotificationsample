//
//  ViewController.swift
//  GroupNotificationSample
//
//  Created by Apple on 16/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Ask for Notification Permissions
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    // Handle error or not granted scenario
                }
            }
        }
    }
    
    @IBAction func clickMeAction(_ sender: Any) {
        scheduleGroupedNotifications()
    }
    
    func scheduleGroupedNotifications() {
        for i in 1...8 {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Hello!"
            notificationContent.sound = UNNotificationSound.default()
            
            if i % 2 == 0 {
                notificationContent.body = "Good Morning, Have a nice day"
                
                notificationContent.threadIdentifier = "Sparkout-HR"
                 // notificationContent.summaryArgument = "your HR"
            } else {
                notificationContent.body = "Hello, Wish you a great day"
                
                notificationContent.threadIdentifier = "Sparkout-TL"
                 // notificationContent.summaryArgument = "your TL"
            }
            
            // Deliver the notification in five seconds.
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // Schedule the notification.
            let request = UNNotificationRequest(identifier: "\(i)FiveSecond", content: notificationContent, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error: Error?) in
                if let theError = error {
                    print(theError)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

