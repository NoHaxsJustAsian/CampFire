import UIKit
import FirebaseAuth
import FirebaseFirestore
import LocalAuthentication

class ViewController: UIViewController, UITextFieldDelegate {
    
    let defaults = UserDefaults.standard
    let mainScreen = MainScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var daysOfWeek = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]
    
    var listMap = [String:List]()
    var selectedList: List! //day of the week
    var currentUser: User?
    
    let database = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    var frameView: UIView!
    
    
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            print("auth user: ", user?.uid)
            if user == nil{
                // Not signed in...
                self.currentUser = nil
                self.defaults.set(false, forKey: "biometricSwitch")
                self.mainScreen.labelText.text = "Please sign in your To Dos!"
                // Hide the addTaskButton and addTaskTextField...
                self.mainScreen.addTaskButton.isHidden = true
                self.mainScreen.addTaskTextField.isHidden = true
                // Hide the entire tableView...
                self.mainScreen.tableViewToDo.isHidden = true
                // Reset tableView...
                self.listMap = [:]
                self.mainScreen.tableViewToDo.reloadData()
                // Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else {
                // The user is signed in...
                // Show the addTaskButton and addTaskTextField...
                self.mainScreen.addTaskButton.isHidden = false
                self.mainScreen.addTaskTextField.isHidden = false
                // Show the entire tableView...
                self.mainScreen.tableViewToDo.isHidden = false
                
                let userData = self.database.collection("users").document(user!.uid)
                userData.getDocument { (document, error) in
                    if let document = document, document.exists {
                        do {
                            let user = try document.data(as: User.self)
                            self.currentUser = user
                            self.fetchLists(fetchUser: user)
                            self.mainScreen.labelText.text = "Welcome \(user.username)!"
                            self.database.collection("users").getDocuments { (document, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
                                } else {
                                    self.navigationItem.titleView = self.mainScreen.titleView
                                }
                            }
                        } catch {
                            print("Error decoding user data: \(error)")
                        }
                    } else {
                        print("User document does not exist")
                    }
                }
                
                //MARK: Logout bar button...
                self.setupRightBarButton(isLoggedin: true)
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        self.view.isHidden = true
        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Allow biometrics to login"
            
            // Perform biometric authentication
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if success {
                        // Authentication successful
                        // Show the view
                        self.view.isHidden = false
                    } else {
                        // Authentication failed
                        // Hide the view and show an error message
                        self.view.isHidden = true
                        self.showAlert(title: "Error!", message: "Biometric check failed. Logged out.")
                        self.onLogOutBarButtonTapped()
                        self.view.isHidden = false
                    }
                }
            }
        } else {
            self.view.isHidden = false
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do"
        
        mainScreen.addTaskTextField.delegate = self
        mainScreen.addTaskTextField.returnKeyType = .done
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewToDo.delegate = self
        mainScreen.tableViewToDo.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewToDo.separatorStyle = .none
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        self.mainScreen.leftArrowButton.addTarget(self, action: #selector(self.leftArrowButtonTapped), for: .touchUpInside)
        self.mainScreen.rightArrowButton.addTarget(self, action: #selector(self.rightArrowButtonTapped), for: .touchUpInside)
        self.mainScreen.addTaskButton.addTarget(self, action: #selector(self.addTaskTapped(_:)), for: .touchUpInside)
        self.frameView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        
        // Keyboard stuff.
        let center: NotificationCenter = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        // Cause the text field to resign its first responder status, effectively dismissing the keyboard
        mainScreen.addTaskTextField.resignFirstResponder()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func fetchLists(fetchUser:User){
        let dispatchGroup = DispatchGroup()
        for day in daysOfWeek {
            dispatchGroup.enter()
            fetchTasks(fetchUser, day) { (fetchedTasks) in
                self.listMap[day] = List(id:day,name: day.capitalized,tasks:fetchedTasks)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            // This code will be executed after all tasks are fetched
            let date = Date()
            let calendar = Calendar.current
            let dayOfWeek = calendar.component(.weekday, from: date) - 1
            let dateFormatter = DateFormatter()
            let dayOfWeekString = dateFormatter.weekdaySymbols[dayOfWeek].lowercased()
            self.selectedList = self.listMap[dayOfWeekString]
            self.mainScreen.tableViewToDo.reloadData()
        }
    }
    
    func fetchTasks(_ fetchUser:User, _ day:String, completion: @escaping ([Task]) -> Void) {
        var fetchedTasks = [Task]()
        self.database.collection("users").document(fetchUser.id!).collection("lists").document(day).collection("tasks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let task = try document.data(as: Task.self)
                        fetchedTasks.append(task)
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                }
                fetchedTasks.sort { $1.finished && !$0.finished }
                completion(fetchedTasks)
            }
        }
    }
    
    @objc func leftArrowButtonTapped() {
        //FIXME: make days shift left and the correct list is being chosen and update the title
    }
    
    @objc func rightArrowButtonTapped() {
        //FIXME: make days shift right and the correct list is being chosen and update the title
    }
    
    @objc func addTaskTapped(_ sender: UIButton) {
        // Retrieve the task name and day from the appropriate UI elements
        guard let taskName = mainScreen.addTaskTextField.text,
              let day = selectedList?.id,
              let userId = currentUser?.id else {
            // Handle the case where the required values are not available
            return
        }
        
        // Create the task object
        var task = Task()
        if !taskName.isEmpty {
            task.name = taskName
        }
        
        let taskData: [String: Any] = [
            "finished": task.finished,
            "name": task.name
        ]
        
        // Add the task data to Firestore
        self.database.collection("users").document(userId).collection("lists").document(day).collection("tasks").addDocument(data: taskData) { error in
            if let e = error {
                print("Error adding document: \(e)")
            } else {
                print("Document added successfully")
                
                // Refresh the lists
                guard let user = self.currentUser else {
                    print("Current user is not set")
                    return
                }
                
                self.fetchLists(fetchUser: user)
            }
        }
        mainScreen.addTaskTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // This will dismiss the keyboard
        
        if textField == mainScreen.addTaskTextField {
            // Call your function to add a task
            self.addTaskTapped(mainScreen.addTaskButton)
        }
        
        return true
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.size.height
        
        // Adjust the frame of your content view to push it up
        mainScreen.frame.origin.y = -keyboardHeight
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Reset the frame of your content view when the keyboard is hidden
        mainScreen.frame.origin.y = 0
        
    }
    
}
