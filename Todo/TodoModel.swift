//
//  TodoModel.swift
//  Todo
//
//  Created by 华润明 on 15/3/16.
//  Copyright (c) 2015年 华润明. All rights reserved.
//

import Foundation

class ToDoModel: NSObject {
    var id: String
    var image: String
    var title: String
    var date: NSDate
    
    init (id: String,image: String,title: String,date: NSDate){
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}