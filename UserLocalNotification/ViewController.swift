//
//  ViewController.swift
//  UserLocalNotification
//
//  Created by mac on 31.08.2018.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!

    var sectionTitle = [String]()
    var data = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.sectionTitle = ["Default Notifications", "Attachment Notification", "Notification witkh Action", "Notification with Custom UI"]
        self.data = [
            ["Time Interval Trigger", "Calendar Trigger", "Location Trigger"],
            ["Notification with Image", "Notification with Image Gif", "Notification with Audio", "Notification with Video"],
            ["Set Categories", "Notification with Category 1", "Notification with category 2", "Notification with category 3"],
            ["Notification with CustomUI", "Notification with CustomUI and Media Player"]
        ]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitle[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = data[indexPath.section][indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case let (section, row) where section == 0 && row == 0 :
            UserNotificationManager.shared.addNotificationWithTimeIntervalTriger()
            break
        case let (section, row) where section == 0 && row == 1 :
            UserNotificationManager.shared.addNotificationWithCalendarTriger()
            break
        case let (section, row) where section == 0 && row == 2 :
            UserNotificationManager.shared.addNotificationWithLocationTriger()
            break
        case let (section, row) where section == 1 && row == 0 :
            UserNotificationManager.shared.addNotificationWithAttachmentType(type: .image)
            break
        case let (section, row) where section == 1 && row == 1 :
            UserNotificationManager.shared.addNotificationWithAttachmentType(type: .imageGif)
            break
        case let (section, row) where section == 1 && row == 2 :
            UserNotificationManager.shared.addNotificationWithAttachmentType(type: .audio)
            break
        case let (section, row) where section == 1 && row == 3 :
            UserNotificationManager.shared.addNotificationWithAttachmentType(type: .video)
            break
        case let (section, row) where section == 2 && row == 0 :
            UserNotificationManager.shared.setCategories()
            break
        case let (section, row) where section == 2 && row == 1 :
            UserNotificationManager.shared.addNotificationWithCategory1()
            break
        case let (section, row) where section == 2 && row == 2 :
            UserNotificationManager.shared.addNotificationWithCategory2()
            break
        case let (section, row) where section == 2 && row == 3 :
            UserNotificationManager.shared.addNotificationWithCategory3()
            break
        case let (section, row) where section == 3 && row == 0 :
            UserNotificationManager.shared.addLocalCustomUI()
            break
        case let (section, row) where section == 3 && row == 1 :
            UserNotificationManager.shared.addCustomUIMadiaPlay()
            break
        default: break
        }
    }

}

