//
//  InputViewController.swift
//  taskapp
//
//  Created by Mac Owner on 2018/04/13.
//  Copyright © 2018年 Mac Owner. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import Foundation

class InputViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var contentstextfield: UITextView!
    @IBOutlet weak var titletextfield: UITextField!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    var task: Task! //追加する
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      titletextfield.delegate = self
        
    }
        
    @objc func dismissKeyboard()
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self.action:#selector(self.dismissKeyboard)){
       self.view.addGestureRecognizer(tapGesture)
    
        titleTextField.text = task.title
       contentsTextView.text = task.contents
      datepicker.date = task.date
    textField.delegate = self
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
           
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentstextfield.text
            self.task.date = self.datepicker.date
            self.realm.add(self.task, update: true)
        }
      
            return ture
          titleTextField.text = titleTextField.text
        }
        setNotification(task: Task)
       super.viewWillDisappear(animated)
    }
    // タスクのローカル通知を登録する
        func setNotification(task: Task) {
            let content = UNMutableNotificationContent()
            // タイトルと内容を設定(中身がない場合メッセージ無しで音だけの通知になるので「(xxなし)」を表示する)
            if task.title == "" {
                content.title = "(タイトルなし)"
            } else {
                content.title = task.title
            }
            if task.contents == "" {
                content.body = "(内容なし)"
            } else {
                content.body = task.contents
            }
            content.sound = UNNotificationSound.default()
            
            // ローカル通知が発動するtrigger（日付マッチ）を作成
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: task.date)
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponents, repeats: false)
            
            // identifier, content, triggerからローカル通知を作成（identifierが同じだとローカル通知を上書き保存）
            let request = UNNotificationRequest.init(identifier: String(task.id), content: content, trigger: trigger)
            
            // ローカル通知を登録
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                print(error ?? "ローカル通知登録 OK")  // error が nil ならローカル通知の登録に成功したと表示します。errorが存在すればerrorを表示します。
            }
            @objc func dismissKeyboard(){
                // キーボードを閉じる
                self.view.endEditing(true)
            }
            center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            for request in requests {
                print("/---------------")
                print(request)
                print("---------------/")
    }
}

           
}

