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
    
    /// Schedule a local notification for a new concert
    func scheduleNotification(for concertName: String, date: String, venue: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Concert Nearby!"
        content.body = "Don't miss \(concertName) at \(venue) on \(date)."
        content.sound = .default
        
        // Set the trigger to fire immediately
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        // Create a unique identifier for each notification
        let identifier = "concert_\(concertName)_\(date)".replacingOccurrences(of: " ", with: "_")
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Add the notification request
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for concert: \(concertName)")
            }
        }
    }
}
