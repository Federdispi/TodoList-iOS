//
//  CategoriesViewController.swift
//  todolist
//
//  Created by Federico Di Spirito on 22/12/2022.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let category = categories[indexPath.row]
        cell.titleTODO.text = category.category
        cell.doneButton.setTitle("✏️", for: .normal)
        cell.closure = {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    var categories = [TodoList]()
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "main" {
            let mainViewController = segue.destination as! ViewController
            let myIndexPath = categoriesTableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            mainViewController.category = categories[row]
        } else if segue.identifier == "modify" {
            let modifyViewController = segue.destination as! ModifyViewController
            let myIndexPath = categoriesTableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            modifyViewController.category = categories[row]
        }
    }
    
    @IBAction func unwindFromModifyVC(_ unwindSegue: UIStoryboardSegue) {
        let modifyViewController = unwindSegue.source as! ModifyViewController
        if modifyViewController.categoryTitle!.text != "" {
            modifyViewController.category?.category = modifyViewController.categoryTitle!.text!
        }
        categoriesTableView.reloadData()
    }
    
    @IBAction func unwindFromNewVC(_ unwindSegue: UIStoryboardSegue) {
        let newViewController = unwindSegue.source as! NewViewController
        if newViewController.categoryTitle!.text != "" {
            categories.append(TodoList(category: newViewController.categoryTitle!.text!, sections: []))
        }
        categoriesTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoriesTableView.dataSource = self
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
