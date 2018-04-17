//
//  Task.swift
//  taskapp
//
//  Created by Mac Owner on 2018/04/14.
//  Copyright © 2018年 Mac Owner. All rights reserved.
//


import RealmSwift

class Task: Object {
    //管理用ID プライマリーキー
    @objc dynamic var id = 0
    //タイトル
    @objc dynamic var title = ""
    //カテゴリー
    @objc dynamic var category = ""
    //内容
    @objc dynamic var contents = ""
    //日時
    @objc dynamic var date = Date()
    /** idをプライマリキーとして設定する*/
    override static func primaryKey() -> String?{
    return "id"
    }
}
