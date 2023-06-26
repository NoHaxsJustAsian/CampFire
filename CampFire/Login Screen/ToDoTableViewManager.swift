import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList?.tasks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoTableViewCell
        if let task = selectedList?.tasks[indexPath.row] {
            cell.labelText.text = task.name
            let _switch = UISwitch() //FIXME: may need to move UISwitch to the TODOCELL.
            _switch.isOn = task.finished
            cell.accessoryView = _switch //FIXME: add call to check the status of this switch and update if necessary.
        }
        return cell
    }    
    
    //FIXME: Test this. We also need to make this call the API call which changes it in the firebase to also delete, rather than jsut deleting it from the table.
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
                      //FIXME: add in settings to disable this confirmation
                    alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                        //Cancel Action
                    }))
                    alert.addAction(UIAlertAction(title: "Yes",
                                                  style: UIAlertAction.Style.default,
                                                  handler: {(_: UIAlertAction!) in
                        //delete contact function
  
                    }))
                     
                    DispatchQueue.main.async {
                        self.present(alert, animated: false, completion: nil)
                    }
            // Delete the row from the data source
            // ...
            
            // Call the completion handler to dismiss the swipe action
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    //FIXME: Test this. We also need to make this call the API call which changes it in the firebase to also delete, rather than jsut deleting it from the table.
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let moveAction = UIContextualAction(style: .normal, title: "Move") { (action, view, completionHandler) in
            // Create the view controller for the popover
            let popoverContentViewController = PopoverContentViewController()
            
            // Customize the popover appearance if needed
            popoverContentViewController.modalPresentationStyle = .popover
            
            // Set the size of the popover content view controller
            popoverContentViewController.preferredContentSize = CGSize(width: 200, height: 200)
            
            // Set the source view and source rect for the popover presentation
            popoverContentViewController.popoverPresentationController?.sourceView = view
            popoverContentViewController.popoverPresentationController?.sourceRect = view.bounds
            
            // Set the delegate to handle dismissal of the popover
            //popoverContentViewController.popoverPresentationController?.delegate = self
            
            // Set the completion handler to handle the selected option
            popoverContentViewController.completionHandler = { selectedOption in
                print("Selected Option: \(selectedOption)")
                // Perform the move action using the selected day
                
            }
            
            
            
            // Present the popover
            self.present(popoverContentViewController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        // Set the button color
        moveAction.backgroundColor = UIColor.systemBlue
        
        let configuration = UISwipeActionsConfiguration(actions: [moveAction])
        return configuration
    }


    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // Your view controller code...
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return daysOfWeek.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return daysOfWeek[row]
    }
}


class PopoverContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var completionHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        cell.textLabel?.text = daysOfWeek[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedOption = daysOfWeek[indexPath.row]
        
        // Call the completion handler with the selected option
        completionHandler?(selectedOption)
        
        // Dismiss the popover
        dismiss(animated: true, completion: nil)
    }
}
