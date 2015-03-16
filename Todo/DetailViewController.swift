//
//  DetailViewController.swift
//  Todo
//
//  Created by 华润明 on 15/3/17.
//  Copyright (c) 2015年 华润明. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var socia: UIButton!
    @IBOutlet weak var food: UIButton!
    @IBOutlet weak var read: UIButton!
    @IBOutlet weak var game: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    @IBOutlet weak var todoDate: UIDatePicker!
    var todo: ToDoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItem.delegate = self
        if todo == nil {
            socia.selected = true
            navigationController?.title = "新增Todo"
        }
        else {
            navigationController?.title = "修改Todo"
            if todo?.image == "selectedsocia"{
                socia.selected = true
            }
            else if todo?.image == "selectedfood"{
                food.selected = true
            }
            else if todo?.image == "selectedread"{
                read.selected = true
            }
            else if todo?.image == "selectedgame"{
                game.selected = true
            }
            
            todoItem.text = todo?.title
 
            todoDate.setDate((todo?.date)!, animated: false)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()}
        // Dispose of any resources that can be recreated.
    @IBAction func sociaTapped(sender: AnyObject) {
        socia.selected = true
        food.selected = false
        read.selected = false
        game.selected = false
    }
    @IBAction func foodTapped(sender: AnyObject) {
        food.selected = true
        socia.selected = false
        read.selected = false
        game.selected = false
    }
    @IBAction func readTapped(sender: AnyObject) {
        read.selected = true
        socia.selected = false
        food.selected = false
        game.selected = false
    }
    @IBAction func gameTapped(sender: AnyObject) {
        game.selected = true
        socia.selected = false
        food.selected = false
        read.selected = false
    }
    @IBAction func okTapped(sender: AnyObject) {
        var image = ""
        if socia.selected{
            image = "selected-socia"
        }
        else if food.selected{
            image = "selected-food"
        }
        else if read.selected{
            image = "selected-read"
        }
        else if game.selected{
            image = "selected-game"
        }
        
        if todo == nil {
            let uuid = NSUUID().UUIDString
            todo = ToDoModel(id: uuid, image: image, title: todoItem.text, date: todoDate.date)
            todos.append(todo!)
        }
        else {
            todo?.image = image
            todo?.title = todoItem.text
            todo?.date = todoDate.date
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
