//
//  ViewController.swift
//  taskapp
//
//  Created by Mac Owner on 2018/04/13.
//  Copyright © 2018年 Mac Owner. All rights reserved.
//

import UIKit
import RealmSwift   // ←追加
import UserNotifications



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
   
   
   @IBOutlet weak var tableView: UITableView!
   
   
   
   @IBOutlet weak var SearchBar: UISearchBar!
   
   
   let realm = try! Realm()
   var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath: "date", ascending: false)
   let datalist =  ["Category"]
   var searchResult = [String]()
   
   override func viewDidLoad(){
      
      super.viewDidLoad()
      
      // Do any additional setup after loading the view, typically from a nib.
      tableView.delegate = self
      tableView.dataSource = self
      SearchBar.enablesReturnKeyAutomatically = false
      searchResult = datalist
      SearchBar.delegate = self
     
      
   }
   
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return taskArray.count
   
   }
   
   // 各セルの内容を返すメソッド
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // 再利用可能な cell を得る
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
      
      // Cellに値を設定する.
      let task = taskArray[indexPath.row]
      cell.textLabel?.text = task.title
      
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm"
      
      let dateString:String = formatter.string(from: task.date)
      cell.detailTextLabel?.text = dateString
      
      return cell
   }
   // 入力画面から戻ってきた時に TableView を更新させる
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      tableView.reloadData()
   }
   // MARK: UITableViewDelegateプロトコルのメソッド
   // 各セルを選択した時に実行されるメソッド
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "cellSegue",sender: nil)
   }
   
   // セルが削除が可能なことを伝えるメソッド
   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCellEditingStyle {
      return .delete
     
      
   }
   
   // Delete ボタンが押された時に呼ばれるメソッド
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         
         let task = self.taskArray[indexPath.row]
         
         let center = UNUserNotificationCenter.current()
         center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
         // データベースから削除する  // ←以降追加する
         try! realm.write {
            self.realm.delete(task)
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
         center.getPendingNotificationRequests{(requests: [UNNotificationRequest]) in
            for request in requests {
               print("/---------------")
               print(request)
               print("---------------/")
            }
         }
      }
      
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?){
      let inputViewController:InputViewController = segue.destination as! InputViewController
      
      if segue.identifier == "cellSegue"{
         let indexPath = self.tableView.indexPathForSelectedRow
         inputViewController.task = self.taskArray[indexPath!.row]
      }else{
         let task = Task()
         task.date = Date()
         
         let taskArray = self.realm.objects(Task.self)
         if taskArray.count != 0{
            task.id = taskArray.max(ofProperty: "id")! + 1
         }
         inputViewController.task = task
      }
   }
   
   //MARK: SearchBarAction
   // 検索ボタンが押された時に呼ばれる
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      print("searchBarSearchButtonClicked")
      self.view.endEditing(true)
      
      searchBar.showsCancelButton = true
      self.searchResult.removeAll()
      
      if(searchBar.text == ""){
         self.searchResult = self.datalist
      }else{
         for date in self.datalist{
            if date.contains(searchBar.text!){
               self.searchResult.append(date)
            }
         }
         
         
         
         tableView.reloadData()
         
      }
   }
   // テキストフィールド入力開始前に呼ばれる
   func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
      print("searchBarShouldBeginEditing")
      searchBar.showsCancelButton = true
      return true
   }
   // キャンセルボタンが押された時に呼ばれる
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      print("searchBarCancelButtonClicked")
      searchBar.showsCancelButton = false
      self.view.endEditing(true)
      
      
   
      }
   }
   



















