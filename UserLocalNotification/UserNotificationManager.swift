//
//  UserNotificationManager.swift
//  UserLocalNotification
//
//  Created by mac on 31.08.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

enum AttachmentType {
    case image
    case imageGif
    case audio
    case video
}

class UserNotificationManager: NSObject {
    
    static let shared = UserNotificationManager()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
    func registerNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            //handle error
        }
    }
    
    //MARK: - Add Default Notification
    func addNotificationWithTimeIntervalTriger() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "timeInterval", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            //handle error
        }
    }
    
    func addNotificationWithCalendarTriger() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        //content.badge = 1
        content.sound = UNNotificationSound.default()
        
        var componects = DateComponents()
        componects.weekday = 5
        componects.hour = 13
        
        let triger = UNCalendarNotificationTrigger(dateMatching: componects, repeats: true)
        let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            //handle error
        }
    }
    
    func addNotificationWithLocationTriger() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        //content.badge = 1
        content.sound = UNNotificationSound.default()
        
        let centr = CLLocationCoordinate2DMake(68.97917, 33.09251)
        let region = CLCircularRegion(center: centr, radius: 100, identifier: "centr")
        region.notifyOnEntry = false
        region.notifyOnExit = true
        
        let triger = UNLocationNotificationTrigger(region: region, repeats: true)
        let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            //handle error
        }
    }
    
    //MARK: - Add Notification with Attachment
    
    func addNotificationWithAttachmentType(type: AttachmentType) {
        
        var contentSubtitle = ""
        var url: URL?
        
        switch type {
        case .image:
            contentSubtitle = "Sebtitle Image"
            url = Bundle.main.url(forResource: "remo", withExtension: "jpg")
            break
        case .imageGif:
            contentSubtitle = "Sebtitle Image Gif"
            url = Bundle.main.url(forResource: "kofi", withExtension: "gif")
            break
        case .audio:
            contentSubtitle = "Sebtitle Audio"
            url = Bundle.main.url(forResource: "war", withExtension: "wav")
            break
        case .video:
            contentSubtitle = "Sebtitle Video"
            url = Bundle.main.url(forResource: "water", withExtension: "mp4")
            break
        }
        
        let content = contentWith(contentSubtitle)
        
        do {
        let attachment = try UNNotificationAttachment(identifier: "attach", url: url!, options: nil)
            content.attachments = [attachment]
            self.addDelayNotificationWith(content)
        } catch {
            print("make attachment error!")
        }
    }
    
    //MARK - Add Notification with Action
    func setCategories() {
        
        let action1 = UNNotificationAction(identifier: "action1", title: "Action 1", options: .authenticationRequired)
        let action2 = UNNotificationAction(identifier: "action2", title: "Start the app", options: .foreground)
        let category1 = UNNotificationCategory(identifier: "category1", actions: [action1, action2], intentIdentifiers: [], options: [])
        
        let action3 = UNNotificationAction(identifier: "action3", title: "Red Style", options: .destructive)
        let action4 = UNNotificationAction(identifier: "action4", title: "Unlock and delete", options: [.authenticationRequired, .destructive])
        let categori2 = UNNotificationCategory(identifier: "category2", actions: [action3, action4], intentIdentifiers: [], options: [])
        
        let action5 = UNTextInputNotificationAction(identifier: "action5", title: "", options: .foreground, textInputButtonTitle: "Send", textInputPlaceholder: "Enter something")
        let category3 = UNNotificationCategory(identifier: "category3", actions: [action5], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category1, categori2, category3])
    }
    
    func addNotificationWithCategory1() {
        let content = contentWith("Category 1")
        content.categoryIdentifier = "category1"
        addDelayNotificationWith(content)
    }
    
    func addNotificationWithCategory2() {
        let content = contentWith("Category 2")
        content.categoryIdentifier = "category2"
        addDelayNotificationWith(content)
    }
    
    func addNotificationWithCategory3() {
        let content = contentWith("Category 3")
        content.categoryIdentifier = "category3"
        addDelayNotificationWith(content)
    }
    
    //MARK - Add Notification with Custom UI
    func addLocalCustomUI() {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "categoryCustomUI"
        
        let url = Bundle.main.url(forResource: "remo", withExtension: "jpg")
        do {
            let attachment = try UNNotificationAttachment(identifier: "attach", url: url!, options: nil)
            content.attachments = [attachment]
            self.addDelayNotificationWith(content)
        } catch {
            print("make attachment error!")
        }
        
    }
    
    func addCustomUIMadiaPlay() {
        let playAction = UNNotificationAction(identifier: "play_action", title: "Play", options: .authenticationRequired)
        let printAction = UNNotificationAction(identifier: "print_action", title: "Print Text", options: .authenticationRequired)
        let commentAction = UNTextInputNotificationAction(identifier: "comment_action", title: "Comment", options: .foreground, textInputButtonTitle: "Send", textInputPlaceholder: "Enter something")
        let category = UNNotificationCategory(identifier: "categoryCustomUI", actions: [playAction, printAction, commentAction], intentIdentifiers: [], options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    //MARK: - Private
    func contentWith(_ subtitle: String) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = subtitle
        content.body = "Body"
        content.sound = UNNotificationSound.default()
        
        return content
    }
    
    func addDelayNotificationWith(_ content: UNNotificationContent) {
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "timeInterval", content: content, trigger: triger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print("Add notification: \((error != nil) ? "error" : "success")")
        }
    }
    
}

extension UserNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willPresentNotification")
        completionHandler([.alert, .sound])
    }
    
    //После срабатывания уведомлений направтяются в этот метод
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler() //пробежатся по респонсу и взять идентификатор который был нажат
    }
    
}


