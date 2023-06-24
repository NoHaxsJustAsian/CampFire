import UIKit

class MainScreenView: UIView {
    var labelText: UILabel!
    var tableViewToDo: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabelText()
        setupTableViewToDo()
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
