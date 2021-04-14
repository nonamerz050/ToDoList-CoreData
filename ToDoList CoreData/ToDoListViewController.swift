//
//  ViewController.swift
//  ToDoList CoreData
//
//  Created by MacBook Pro on 12.04.2021.

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    private let cellID = "cell"
    private var tasks = StorageManager.shared.fetchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func setupNavigationBar() {
        title = "ToDo List"
//        Large title commented out
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = .darkGray
        navigationController?.navigationBar.standardAppearance = navBarAppearance
//        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        
        navigationController?.navigationBar.tintColor = .white
    }

    @objc private func addNewTask() {
//        let newTaskVC = NewTaskViewController()
//        newTaskVC.modalPresentationStyle = .fullScreen
//        present(newTaskVC, animated: true)
        showAlert()
        
        }
    }
    
// MARK: - UITableViewDataSource
extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ToDoListViewController {
    
    // Edit task
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        showAlert(task: task) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = tasks[indexPath.row]
        
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(task)
        }
    }
}

// MARK: - Alert Controller
extension ToDoListViewController {
    
    private func showAlert(task: Task? = nil, completion: (() -> Void)? = nil) {
        
        var title = "New Task"
        if task != nil { title = "Update Task" }
        
        let alert = AlertController(title: title, message: "What do you want to do?", preferredStyle: .alert)
        
        alert.action(task: task) { newValue in
            if let task = task, let completion = completion {
                StorageManager.shared.edit(task, newName: newValue)
                completion()
            } else {
                StorageManager.shared.save(newValue) { task in
                    self.tasks.append(task)
                    self.tableView.insertRows(
                        at: [IndexPath(row: self.tasks.count - 1, section: 0)],
                        with: .automatic
                    )
                }
            }
        }
        
        present(alert, animated: true)
    }
}
