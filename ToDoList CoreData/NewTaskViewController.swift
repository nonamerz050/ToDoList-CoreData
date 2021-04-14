// //
// //  NewTaskViewController.swift
// //  ToDoList CoreData
// //
// //  Created by MacBook Pro on 12.04.2021.
// //
//
//import UIKit
//import CoreData
//
//class NewTaskViewController: UIViewController {
//
//    private var viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    private lazy var newTaskLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Enter new task:"
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textAlignment = .center
//        label.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//        return label
//    }()
//
//    private lazy var newTaskTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "New Task"
//        textField.borderStyle = .roundedRect
//        textField.backgroundColor = #colorLiteral(red: 0.8590634465, green: 0.8529273272, blue: 0.8637626767, alpha: 1)
//        return textField
//    }()
//
//    private lazy var saveButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = .darkGray
//        button.setTitle("Save task", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(save), for: .touchUpInside)
//        return button
//    }()
//
//    private lazy var cancelButton: UIButton = {
//        let button = UIButton()
//        button.backgroundColor = #colorLiteral(red: 0.5906925797, green: 0, blue: 0.004298701882, alpha: 1) //color literal
//        button.setTitle("Cancel", for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//
//        setupSubviews()
//    }
//
//    private func setupSubviews() {
//        view.addSubview(newTaskTextField)
//        view.addSubview(saveButton)
//        view.addSubview(cancelButton)
//        view.addSubview(newTaskLabel)
//
//        setupConstraints()
//    }
//
//    private func setupConstraints() {
//        newTaskTextField.translatesAutoresizingMaskIntoConstraints = false
//        saveButton.translatesAutoresizingMaskIntoConstraints = false
//        cancelButton.translatesAutoresizingMaskIntoConstraints = false
//        newTaskLabel.translatesAutoresizingMaskIntoConstraints = false
//
//
//        NSLayoutConstraint.activate([
//            newTaskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
//            newTaskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            newTaskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//        ])
//
//        NSLayoutConstraint.activate([
//            newTaskTextField.topAnchor.constraint(equalTo: newTaskLabel.bottomAnchor, constant: 20),
//            newTaskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            newTaskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//        ])
//
//        NSLayoutConstraint.activate([
//            saveButton.topAnchor.constraint(equalTo: newTaskTextField.bottomAnchor, constant: 40),
//            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//        ])
//
//        NSLayoutConstraint.activate([
//            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
//            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
//            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
//        ])
//    }
//
//    @objc private func save() {
//
//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Task", in: viewContext) else { return }
//        guard let task = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Task else { return }
//        task.name = newTaskTextField.text
//
//        do {
//            try viewContext.save()
//        } catch let error {
//            print(error.localizedDescription)
//        }
//        dismiss(animated: true)
//    }
//
//    @objc private func cancel() {
//        dismiss(animated: true)
//    }
//}
