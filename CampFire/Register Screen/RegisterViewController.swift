import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    let database = Firestore.firestore()

    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        registerView.buttonRegister.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        title = "Register"
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)

    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase...
        //TODO: manually add all days of the week into lists.
        registerNewAccount { user, error in
            if let error = error {
                print("Error: \(error)")
            } else if let user = user {
                let name = self.registerView.textFieldName.text
                self.database.collection("users").document(user.uid).setData([
                    "username": name
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(user.uid)")
                    }
                }
            }
        }
    }
}
