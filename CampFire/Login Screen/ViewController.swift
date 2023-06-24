import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {

    let mainScreen = MainScreenView()

    var usersList = [User]() //FIXME: Change this into a list of ToDos

    var handleAuth: AuthStateDidChangeListenerHandle?

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
                self.mainScreen.labelText.text = "Please sign in your ToDos!"

                //MARK: Reset tableView...
                self.usersList.removeAll()
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
                            self.mainScreen.labelText.text = "Welcome \(user.username)!"
                            self.database.collection("users").getDocuments { (querySnapshot, error) in
                                if let error = error {
                                    print("Error getting documents: \(error)")
                                } else {
                                    var userIds: [User] = []
                                    for document in querySnapshot!.documents {
                                        do {
                                            if (document.documentID != self.currentUser?.id) {
                                                let user = try document.data(as: User.self)
                                                userIds.append(user)
                                            }
                                        } catch {
                                            print("Error decoding user data: \(error)")
                                        }
                                    }
                                    self.usersList = userIds.sorted { $0.username < $1.username }
                                    print("userlist: ", self.usersList)
                                    print("end")
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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }

    func signIn(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password)
    }

    func openChat(user: User){
        //FIXME: fix this so it allows user to edit
    }
}
