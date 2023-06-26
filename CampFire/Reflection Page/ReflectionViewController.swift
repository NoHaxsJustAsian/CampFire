//
//  ReflectionViewController.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit

class ReflectionViewController: UIViewController {
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var selectedDay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = daysOfWeek[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedDay = daysOfWeek[indexPath.row]
        showPopover()
    }
    
    // MARK: - Popover
    
    private func showPopover() {
        guard let selectedDay = selectedDay else {
            return
        }
        
        let popoverContentViewController = ReflectionPopoverContentViewController()
        //popoverContentViewController.delegate = self
        
        popoverContentViewController.modalPresentationStyle = .popover
        popoverContentViewController.preferredContentSize = CGSize(width: 200, height: 150)
        
        if let popoverPresentationController = popoverContentViewController.popoverPresentationController {
            //popoverPresentationController.delegate = self
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
        popoverContentViewController.selectedDay = selectedDay
        
        present(popoverContentViewController, animated: true, completion: nil)
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}



class ReflectionPopoverContentViewController: UIViewController {
    var selectedDay: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        setupAddButton()
    }
    
    private func setupTextView() {
        let textView = UITextView(frame: CGRect(x: 20, y: 20, width: view.bounds.width - 40, height: 100))
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(textView)
    }
    
    private func setupAddButton() {
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: view.bounds.width - 120, y: 130, width: 100, height: 30)
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
    }
    
    @objc private func addButtonTapped() {
        guard let selectedDay = selectedDay else {
            return
        }
        
        if let textView = view.subviews.first as? UITextView, let task = textView.text {
            print("Adding task: \(task) for day: \(selectedDay)")
            // Perform the task addition logic here
            
            dismiss(animated: true, completion: nil)
        }
    }
}
