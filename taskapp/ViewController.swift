//
//  ViewController.swift
//  taskapp
//
//  Created by Mac Owner on 2018/04/13.
//  Copyright © 2018年 Mac Owner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func tableView(_ tableView: UITableView, nunberofRowsInSection section: Int) -> Int{
    return 0
}
    func tableView(_ tableView: UITableView, cellForrowAt indexPath : IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdntifier: "Cell", for:indexPath)
        return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
}
    func tableView(_ tablerView: UITableView. editingStyleForRowAt indexPath: IndexPath)-> UITableViewCellEditingStyle{
        return .delete
}
    func tableView(_ tableView: UITableView, commit editindStyle: UITabeViewCellEditingStyle, forRowAt indexPath: IndexPath){
    }
}
}



