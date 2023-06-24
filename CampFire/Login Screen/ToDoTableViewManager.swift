import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentUser != nil {
            return selectedList.tasks.count 
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! ToDoTableViewCell
        cell.labelText.text = selectedList.tasks[indexPath.row].name
        // Add a tap gesture recognizer to the label
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        cell.addGestureRecognizer(tapGesture)
        
        let _switch = UISwitch() //FIXME: may need to move UISwitch to the TODOCELL. 
        _switch.isOn = selectedList.tasks[indexPath.row].finished
        cell.accessoryView = _switch //FIXME: add call to check the status of this switch and update if neccessary.
        return cell
    }
    
    
    //FIXME: Test this. We also need to make this call the API call which changes it in the firebase to also delete, rather than jsut deleting it from the table.
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Delete the row from the data source
            // ...
            
            // Call the completion handler to dismiss the swipe action
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    
    
    
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        // Get the cell that contains the label
        guard let cell = sender.view?.superview as? UITableViewCell else {
            return
        }

        // Get the index path of the cell
        guard let indexPath = mainScreen.tableViewToDo.indexPath(for: cell) else {
            return
        }

        // Get the label that was tapped
        guard let label = sender.view as? UILabel else {
            return
        }

        // Create a text field
        let textField = UITextField(frame: label.frame)
        textField.borderStyle = .roundedRect
        textField.text = label.text

        // Replace the label with the text field
        label.removeFromSuperview()
        cell.contentView.addSubview(textField)

        // Set the first responder to the text field
        textField.becomeFirstResponder()

        // Set the text of the label to the text of the text field when the user finishes editing
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:for:)), for: .editingDidEnd)
    }
    
    // Define the action for the text field
    @objc func textFieldDidEndEditing(_ textField: UITextField, for cell: UITableViewCell) {
        // Get the index path of the cell
        guard let indexPath = mainScreen.tableViewToDo.indexPath(for: cell) else {
            return
        }

        // Get the label that was edited
        guard let label = cell.contentView.subviews.first as? UILabel else {
            return
        }

        // Set the text of the label to the text of the text field
        label.text = textField.text

        // Remove the text field and add the label back to the cell
        textField.removeFromSuperview()
        cell.contentView.addSubview(label)
    }
    
    
}
