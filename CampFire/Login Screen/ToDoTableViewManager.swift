import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        //return selectedList.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoTableViewCell
        cell.labelText.text = selectedList.tasks[indexPath.row].name
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
    
}
