import Foundation
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedList?.tasks.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoTableViewCell
        guard let currentUser = currentUser else {
            print("Current user is nil")
            return cell
        }
        if let task = selectedList?.tasks[indexPath.row],
           let userId = currentUser.id,
           let dayId = selectedList?.id {
            cell.labelText.text = task.name
            cell.taskSwitch.isOn = task.finished

            // Adding text edited action closure
            cell.textEditedAction = { [weak self] newText in
                guard let task = self?.selectedList?.tasks[indexPath.row],
                      let taskId = task.id else {
                    print("Task or task id is nil")
                    return
                }
                // Create a reference to the task in Firestore
                let taskRef = self?.database.collection("users").document(userId).collection("lists").document(dayId).collection("tasks").document(taskId)

                // Update the "name" field in the task
                taskRef?.updateData([
                    "name": newText ?? ""
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        // After updating, refetch the table data
                        self?.fetchLists(fetchUser: currentUser)
                    }
                }
                // Update the local data
                self?.selectedList?.tasks[indexPath.row].name = newText ?? ""
            }
            
            cell.switchAction = { [weak self] isOn in
                // Get the task at the indexPath again
                guard let task = self?.selectedList?.tasks[indexPath.row],
                      let taskId = task.id else {
                    print("Task or task id is nil")
                    return
                }
                // Make sure currentUser is not nil
                guard let currentUser = self?.currentUser else {
                    print("Current user is nil")
                    return
                }
                // Create a reference to the task in Firestore
                let taskRef = self?.database.collection("users").document(userId).collection("lists").document(dayId).collection("tasks").document(taskId)

                // Update the "finished" field in the task
                taskRef?.updateData([
                    "finished": isOn
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        // After updating, refetch the table data
                        self?.fetchLists(fetchUser: currentUser)
                    }
                }
                // Update the local data
                self?.selectedList?.tasks[indexPath.row].finished = isOn
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let alert = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            alert.addAction(UIAlertAction(title: "Yes",
                                          style: UIAlertAction.Style.default,
                                          handler: {(_: UIAlertAction!) in
                //delete task function
                if let taskId = self.selectedList?.tasks[indexPath.row].id,
                   let userId = self.currentUser?.id,
                   let dayId = self.selectedList?.id {
                    let taskRef = self.database.collection("users").document(userId).collection("lists").document(dayId).collection("tasks").document(taskId)

                    taskRef.delete() { err in
                        if let err = err {
                            print("Error removing document: \(err)")
                        } else {
                            print("Document successfully removed!")
                            // Remove the task from the local data
                            self.selectedList?.tasks.remove(at: indexPath.row)
                            // Reload the tableView
                            tableView.reloadData()
                        }
                    }
                }
            }))

            DispatchQueue.main.async {
                self.present(alert, animated: false, completion: nil)
            }

            completionHandler(true)
        }

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
