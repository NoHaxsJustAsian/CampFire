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
                      
                    alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: { _ in
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
    
}
