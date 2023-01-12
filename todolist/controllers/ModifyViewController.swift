//
//  ModifyViewController.swift
//  todolist
//
//  Created by Federico Di Spirito on 22/12/2022.
//

import UIKit

class ModifyViewController: UIViewController {

    var category: TodoList? // Selected category
    
    @IBOutlet weak var categoryTitle: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Pass the selected category title in the text field
        if let data = category {
            categoryTitle.text = data.category
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
