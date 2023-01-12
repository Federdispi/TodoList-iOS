//
//  AddViewController.swift
//  todolist
//
//  Created by Federico Di Spirito on 07/11/2022.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoDate: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        todoDate.text = formatter.string(from: date)
        
        // Create a DatePicker and a Toolbar for the Text Field
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame.size = CGSize(width: 0, height: 250)
        let toolbar = UIToolbar();
           toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker(sender:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneDatePicker(sender:)))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        // Add the Toolbar and the DatePicker to the TextField
        todoDate.inputAccessoryView = toolbar
        todoDate.inputView = datePicker
    }
    
    @objc func doneDatePicker(sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        todoDate.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
}
