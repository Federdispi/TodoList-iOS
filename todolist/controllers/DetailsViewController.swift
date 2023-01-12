//
//  DetailsViewController.swift
//  todolist
//
//  Created by Federico Di Spirito on 06/12/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    var todo: Todo? // Selected Todo
    
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var todoDescription: UITextView!
    @IBOutlet weak var todoDate: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pass the Todo info into the text fields
        if let data = todo {
            todoTitle.text = data.nom
            todoDescription.text = data.desc
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            todoDate.text = dateFormatter.string(from: data.date)
        }
        
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

    // Sets the TextField text to the selected date
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
