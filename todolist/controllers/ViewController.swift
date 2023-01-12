//
//  ViewController.swift
//  todolist
//
//  Created by Federico Di Spirito on 07/11/2022.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return category!.sections.count
    }
    
    // Sets the title of the Section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return category!.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category!.sections[section].todos.count
    }
    
    // Creates the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let todo = category!.sections[indexPath.section].todos[indexPath.row]
        cell.titleTODO.text = todo.nom
        cell.doneButton.setTitle(todo.done ? "❌" : "✅", for: .normal)
        cell.closure = {
            todo.done = !todo.done
            tableView.reloadData()
        }
        return cell
    }
    
    // Deletes the cell (and the section if it's empty)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                todoList.remove(at: indexPath.row)
                category!.sections[indexPath.section].todos.remove(at: indexPath.row)
                todoListView.deleteRows(at: [indexPath], with: .fade)
                if category!.sections[indexPath.section].todos.isEmpty {
                    category!.sections.remove(at: indexPath.section)
                    todoListView.reloadData()
                }
            }
        }
    
    // Filters the TodoList with the SearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTodoList = []
        
        if searchText.isEmpty {
            filteredTodoList = todoList
        } else {
            for todo in todoList {
                if todo.nom.lowercased().contains(searchText.lowercased()) {
                    filteredTodoList.append(todo)
                }
            }
        }
        
        category!.sections = groupTODOsByDate(from: filteredTodoList)
        todoListView.reloadData()
    }
    
    var todoList = [Todo]()
    var category: TodoList?
    var filteredTodoList: [Todo]!
    
    @IBOutlet weak var viewTitle: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var todoListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = category {
            viewTitle.text = data.category
            for section in data.sections {
                todoList.append(contentsOf: section.todos)
            }
        }
        
        filteredTodoList = todoList
        
        todoListView.dataSource = self
        searchBar.delegate = self
    }
    
    // Function to group the todos in sections sorted by date
    func groupTODOsByDate(from todos: [Todo]) -> [Section] {
        let grouped = Dictionary(grouping: todos) {
            $0.date
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var sections = grouped.map {
            Section(title: dateFormatter.string(from: $0.key), todos: $0.value)
        }
        sections = sections.sorted(by: {dateFormatter.date(from: $0.title)?.compare(dateFormatter.date(from: $1.title)!) == .orderedAscending})
        return sections
    }
    
    // Passes the selected Todo information to the next View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            let detailsViewController = segue.destination as! DetailsViewController
            let myIndexPath = todoListView.indexPathForSelectedRow!
            let row = myIndexPath.row
            detailsViewController.todo = category!.sections[myIndexPath.section].todos[row]
        }
    }
    
    // Save the modifications made to a Todo
    @IBAction func unwindFromDetailsVC(_ unwindSegue: UIStoryboardSegue) {
        let detailsViewController = unwindSegue.source as! DetailsViewController
        if detailsViewController.todoTitle!.text != "" {
            detailsViewController.todo?.nom = detailsViewController.todoTitle!.text!
            detailsViewController.todo?.desc = detailsViewController.todoDescription!.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: detailsViewController.todoDate.text!)!
            detailsViewController.todo?.date = date
        }
        category!.sections = groupTODOsByDate(from: todoList)
        todoListView.reloadData()
    }
    
    // Adds a new Todo
    @IBAction func unwindFromAddVC(_ unwindSegue: UIStoryboardSegue) {
        let addViewController = unwindSegue.source as! AddViewController
        if addViewController.todoTitle!.text != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let date = dateFormatter.date(from: addViewController.todoDate.text!)!
            todoList.append(Todo(nom: addViewController.todoTitle.text!, desc: addViewController.todoDescription.text!, date: date))
        }
        category!.sections = groupTODOsByDate(from: todoList)
        todoListView.reloadData()
    }
}
