//
//  ReflectionViewController.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit
import FirebaseFirestore

class ReflectionViewController: UIViewController {
    let reflectionView = ReflectionView()
    var daysOfWeek = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]
    let database = Firestore.firestore()
    var remainingTasks = [Task]()
    var currentTask: Task?
    var currentUser: User?
    var currentDayOfWeek: Int = {
        let date = Date()
        let calendar = Calendar.current
        return calendar.component(.weekday, from: date) - 1
    }()
    lazy var selectedDay = daysOfWeek[currentDayOfWeek]
    
    override func loadView() {
        view = reflectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupTableView()
        
        reflectionView.sundayButton.addTarget(self, action: #selector(sundayButtonPressed), for: .touchUpInside)
        reflectionView.mondayButton.addTarget(self, action: #selector(mondayButtonPressed), for: .touchUpInside)
        reflectionView.tuesdayButton.addTarget(self, action: #selector(tuesdayButtonPressed), for: .touchUpInside)
        reflectionView.wednesdayButton.addTarget(self, action: #selector(wednesdayButtonPressed), for: .touchUpInside)
        reflectionView.thursdayButton.addTarget(self, action: #selector(thursdayButtonPressed), for: .touchUpInside)
        reflectionView.fridayButton.addTarget(self, action: #selector(fridayButtonPressed), for: .touchUpInside)
        reflectionView.saturdayButton.addTarget(self, action: #selector(saturdayButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func sundayButtonPressed() {
        
        getNextTask()
        
    }
    
    @objc func mondayButtonPressed() {
        
    }
    
    @objc func tuesdayButtonPressed() {
        
    }
    
    @objc func wednesdayButtonPressed() {
        
    }
    
    @objc func thursdayButtonPressed() {
        
    }
    
    @objc func fridayButtonPressed() {
        
    }
    
    @objc func saturdayButtonPressed() {
        
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
        //showPopover()
    }
    
    // MARK: - Logic Functions for Tasks
    private func getTaskCount() -> String{
        if self.remainingTasks.count == 0 {
            return "All done for today!"
        } else {
            return "\(self.remainingTasks.count) tasks uncompleted today..."
        }
    }

    private func getNextTask() {
        if self.remainingTasks.count == 0 {
            print("No tasks remaining")
            return
        } else {
            self.currentTask = self.remainingTasks[0]
        }
    }
    
    private func getAllTasks() {
        guard let fetchUser = self.currentUser else {
            print("Current user is not set")
            return
        }

        fetchTasks(fetchUser, selectedDay) { (fetchedTasks) in
            self.remainingTasks = fetchedTasks
        }
    }

    
    private func fetchTasks(_ fetchUser:User, _ day:String, completion: @escaping ([Task]) -> Void) {
        var fetchedTasks = [Task]()
        self.database.collection("users").document(fetchUser.id!).collection("lists").document(day).collection("tasks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let task = try document.data(as: Task.self)
                        // Check if task is finished before adding it to the fetchedTasks array
                        if task.finished == true {
                            fetchedTasks.append(task)
                        }
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                }
                // Return the fetched tasks where 'finished' is 'true'
                completion(fetchedTasks)
            }
        }
    }

    
    // MARK: - Popover
    
//    private func showPopover() {
//        guard let selectedDay = selectedDay else {
//            return
//        }
//
//        let popoverContentViewController = ReflectionPopoverContentViewController()
//        //popoverContentViewController.delegate = self
//
//        popoverContentViewController.modalPresentationStyle = .popover
//        popoverContentViewController.preferredContentSize = CGSize(width: 200, height: 150)
//
//        if let popoverPresentationController = popoverContentViewController.popoverPresentationController {
//            //popoverPresentationController.delegate = self
//            popoverPresentationController.sourceView = view
//            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
//            popoverPresentationController.permittedArrowDirections = []
//        }
//
//        popoverContentViewController.selectedDay = selectedDay
//
//        present(popoverContentViewController, animated: true, completion: nil)
//    }
//
//    // MARK: - UIPopoverPresentationControllerDelegate
//
//    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
//        return .none
//    }
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
