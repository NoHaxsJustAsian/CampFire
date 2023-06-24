import UIKit

class MainScreenView: UIView {
    var labelText: UILabel!
    var tableViewToDo: UITableView!
    var leftArrowButton: UIButton!
    var rightArrowButton: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelText()
        setupTableViewToDo()
        setupLeftArrowButton()
        setupRightArrowButton()
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
    
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    
    
    //FIXME: fix these arrows they show up when logging in, next to the To Do, which will change to the name of the day of the week. Also add the logic in the button presses.
    func setupLeftArrowButton(){
        leftArrowButton = UIButton(type: .system)
        leftArrowButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        leftArrowButton.setImage(UIImage(named: "left_arrow"), for: .normal) // Set the image for the left arrow button
        titleView.addSubview(leftArrowButton)
    }
    
    func setupRightArrowButton(){
        rightArrowButton = UIButton(type: .system)
        rightArrowButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightArrowButton.setImage(UIImage(named: "right_arrow"), for: .normal) // Set the image for the left arrow button
        titleView.addSubview(rightArrowButton)
    }
    
    
    
    //MARK: setting up constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableViewToDo.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            tableViewToDo.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewToDo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewToDo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
