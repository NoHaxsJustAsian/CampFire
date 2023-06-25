import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    var handleAuth: AuthStateDidChangeListenerHandle?
    
    var daysOfWeek = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]
    
    var listMap = [String:List]()
    var selectedList: List! //day of the week
    var currentUser: User?
    
    let database = Firestore.firestore()
    
    let childProgressView = ProgressSpinnerViewController()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            print("auth user: ", user?.uid)
            if user == nil{
                //MARK: not signed in...
                self.currentUser = nil
                self.mainScreen.labelText.text = "Please sign in your To Dos!"
                
                //MARK: Reset tableView...
                self.listMap = [:]
                self.mainScreen.tableViewToDo.reloadData()
                
                //MARK: Sign in bar button...
                self.setupRightBarButton(isLoggedin: false)
                
            }else{
                //MARK: the user is signed in...
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
                                    let date = Date()
                                    let calendar = Calendar.current
                                    let dayOfWeek = calendar.component(.weekday, from: date) - 1
                                    let dateFormatter = DateFormatter()
                                    let dayOfWeekString = dateFormatter.weekdaySymbols[dayOfWeek].lowercased()
                                    self.selectedList = self.listMap[dayOfWeekString]
                                    self.mainScreen.tableViewToDo.reloadData()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To Do"
        
        //MARK: patching table view delegate and data source...
        mainScreen.tableViewToDo.delegate = self
        mainScreen.tableViewToDo.dataSource = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewToDo.separatorStyle = .none
        //MARK: Make the titles look large...
        navigationController?.navigationBar.prefersLargeTitles = true
        self.mainScreen.leftArrowButton.addTarget(self, action: #selector(self.leftArrowButtonTapped), for: .touchUpInside)
        self.mainScreen.rightArrowButton.addTarget(self, action: #selector(self.rightArrowButtonTapped), for: .touchUpInside)
        self.mainScreen.addTaskButton.addTarget(self, action: #selector(self.addTaskTapped), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
    
    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func fetchLists(fetchUser:User){
        for day in daysOfWeek {
            self.listMap[day] = List(id:day,name: day.capitalized,tasks:fetchTasks(fetchUser, day))
        }
    }
    
    func fetchTasks(_ fetchUser:User, _ day:String) -> [Task]{
        var fetchedTasks = [Task]()
        self.database.collection("users").document(fetchUser.id!).collection("lists").document(day).collection("tasks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: document, options: [])
                        let task = try JSONDecoder().decode(Task.self, from: data)
                        print(task)
                        fetchedTasks.append(task)
                    } catch {
                        print("Error decoding user data: \(error)")
                    }
                    //self.database.collection("users").document(user!.uid).collection("lists").document(day)
                }
            }
        }
        fetchedTasks.sort { $1.finished && !$0.finished }
        print(fetchedTasks)
        return fetchedTasks
    }
    
    
    @objc func leftArrowButtonTapped() {
        //FIXME: make days shift left and the correct list is being chosen and update the title
    }

    @objc func rightArrowButtonTapped() {
        //FIXME: make days shift right and the correct list is being chosen and update the title
    }
    
    @objc func addTaskTapped(){
        let addTaskAlert = UIAlertController(
            title: "Add Task",
            message: "Enter Your Task Here!",
            preferredStyle: .alert)
        
        //MARK: setting up email textField in the alert...
        addTaskAlert.addTextField{ textField in
            textField.placeholder = "Task Name"
            textField.contentMode = .center
            textField.keyboardType = .emailAddress
        }
        
        //MARK: Sign In Action...
        let addAction = UIAlertAction(title: "Add", style: .default, handler: {(_) in
            if let task = addTaskAlert.textFields![0].text{
                //MARK: sign-in logic for Firebase adding task...
                
            }
        })
        
//        //MARK: Register Action...
//        let registerAction = UIAlertAction(title: "Register", style: .default, handler: {(_) in
//            //MARK: logic to open the register screen...
//            let registerViewController = RegisterViewController()
//            self.navigationController?.pushViewController(registerViewController, animated: true)
//        })
        
        
        //MARK: action buttons...
        addTaskAlert.addAction(addAction)
        //addTaskAlert.addAction(registerAction)
        
        self.present(addTaskAlert, animated: true, completion: {() in
            //MARK: hide the alerton tap outside...
            addTaskAlert.view.superview?.isUserInteractionEnabled = true
            addTaskAlert.view.superview?.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(self.onTapOutsideAlert))
            )
        })
    }
    
}
