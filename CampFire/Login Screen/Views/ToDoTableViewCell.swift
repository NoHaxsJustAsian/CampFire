import UIKit

class ToDoTableViewCell: UITableViewCell, UITextFieldDelegate {

    var stackCell: UIStackView!
    var labelText: UITextField!
    var wrapperCellView: UIView!
    var taskSwitch: UISwitch!
    var switchAction: ((Bool)->())?
    var textEditedAction: ((String?)->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupWrapperCellView()
        setupCell()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = UIColor.systemBackground
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.borderColor = UIColor.orange.cgColor
        wrapperCellView.layer.borderWidth = 0.3
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(wrapperCellView)
    }
    
    func setupCell(){
        labelText = UITextField()
        labelText.font = UIFont.boldSystemFont(ofSize: 20)
        labelText.returnKeyType = UIReturnKeyType.done
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.isUserInteractionEnabled = true  // Set to true to make it editable
        labelText.delegate = self
        labelText.addTarget(self, action: #selector(self.textFieldDidEndOnExit), for: UIControl.Event.editingDidEndOnExit)

        taskSwitch = UISwitch() // Create UISwitch
        taskSwitch.onTintColor = .orange
        taskSwitch.addTarget(self, action: #selector(switchToggled), for: .valueChanged)
        
        stackCell = UIStackView(arrangedSubviews: [labelText, taskSwitch]) // Include UISwitch in the stack
        stackCell.axis = .horizontal
        stackCell.alignment = .center
        stackCell.distribution = .fillProportionally
        stackCell.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(stackCell)
    }
    
    @objc func textFieldDidEndOnExit(_ textField: UITextField) {
        self.textEditedAction?(textField.text)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textEditedAction?(textField.text)
    }

    @objc func switchToggled() {
        print("Switch is toggled")
        switchAction?(taskSwitch.isOn)
    }

    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 1),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 1),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1),
            stackCell.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            stackCell.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor),
            stackCell.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            stackCell.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
            labelText.heightAnchor.constraint(equalTo: stackCell.heightAnchor),
            labelText.widthAnchor.constraint(equalTo: stackCell.widthAnchor, multiplier: 0.8),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
        //FIXME: we prolly want to make this pull up the keyboard and make the LabelText able to be edited.
    }

}
