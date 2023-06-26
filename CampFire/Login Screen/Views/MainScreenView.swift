import UIKit

class MainScreenView: UIView {
    
    var labelText: UILabel!
    var labelTextDayOfWeek: UILabel!
    var tableViewToDo: UITableView!
    var stackView:UIStackView!
    var leftArrowButton: UIButton!
    var rightArrowButton: UIButton!
    var addTaskButton: UIButton!
    var addTaskTextField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemBackground
        
        setupLabelText()
        setupTableViewToDo()
        setupStack()
        setupAddTaskButton()
        setupAddTaskTextField()
        initConstraints()
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = .boldSystemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelText)
    }
    
    func setupTableViewToDo(){
        tableViewToDo = UITableView()
        tableViewToDo.register(ToDoTableViewCell.self, forCellReuseIdentifier: "todo")
        tableViewToDo.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewToDo)
    }
    
    func setupStack(){
        
        leftArrowButton = UIButton(type: .system)
        leftArrowButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftArrowButton.setImage(UIImage(systemName: "chevron.left"), for: .normal) // Set the image for the left arrow button
        leftArrowButton.tintColor = UIColor.orange
        leftArrowButton.setContentHuggingPriority(.required, for: .horizontal)
        leftArrowButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        rightArrowButton = UIButton(type: .system)
        rightArrowButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightArrowButton.setImage(UIImage(systemName: "chevron.right"), for: .normal) // Set the image for the left arrow button
        rightArrowButton.tintColor = UIColor.orange
        rightArrowButton.setContentHuggingPriority(.required, for: .horizontal)
        rightArrowButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        labelTextDayOfWeek = UILabel()
        labelTextDayOfWeek.text = ""
        labelTextDayOfWeek.font = .boldSystemFont(ofSize: 24)
        labelTextDayOfWeek.textColor = .purple
        labelTextDayOfWeek.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [labelTextDayOfWeek,leftArrowButton, rightArrowButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
    }
    
    
    func setupAddTaskButton(){
        addTaskButton = UIButton(type: .system)
        addTaskButton.setTitle("Add Task", for: .normal)
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addTaskButton)
    }
    
    func setupAddTaskTextField(){
        addTaskTextField = UITextField()
        addTaskTextField.placeholder = "✚ Add Task"
        addTaskTextField.tintColor = .orange
        addTaskTextField.keyboardType = .default
        addTaskTextField.returnKeyType = UIReturnKeyType.done
        addTaskTextField.borderStyle = .roundedRect
        addTaskTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addTaskTextField)
    }
    
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            stackView.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            tableViewToDo.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8),
            tableViewToDo.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewToDo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableViewToDo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            addTaskTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addTaskTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addTaskTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -112),
            
            addTaskButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addTaskButton.leadingAnchor.constraint(equalTo: addTaskTextField.trailingAnchor, constant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
