//
//  InputViewController.swift
//  taskapp
//
//  Created by Mac Owner on 2018/04/13.
//  Copyright © 2018年 Mac Owner. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    var task: Task! //追加する
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        
      titleTextField.text = task.title
       contentsTextView.text = task.contents
      datepicker.date = task.date

    
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextField.text!
        self.task.contents = self.contentsTextView.text
            self.task.date = self.datepicker.date
            self.realm.add(self.task, update: true)
        }
        
        super.viewWillDisappear(animated)
    }
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
}
