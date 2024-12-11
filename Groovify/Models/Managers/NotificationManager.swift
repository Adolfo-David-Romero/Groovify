//
//  NotificationManager.swift
//  Groovify
//
//  Created by David Romero on 2024-12-11.
//

import UserNotifications
import UIKit

class NotificationManager {
    static let shared = NotificationManager()
    
    ///request permission from the user to send notifications
    func requestPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
            if granted {
                print("Permission granted!")
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            } else {
                print("Permission denied.")
            }
        }
    }
    
    ///UserNotifications framework to schedule local notifications
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Concert Reminder"
        content.body = "Don't forget about the upcoming concert tonight!"
        content.sound = .default
        
        // Set a trigger (e.g., after 5 seconds)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create a request
        let request = UNNotificationRequest(identifier: "concertReminder", content: content, trigger: trigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
