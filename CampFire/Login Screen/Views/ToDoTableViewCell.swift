import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var stackCell: UIStackView!
    var labelText: UITextField!
    var toggleButton: UIButton!
    var wrapperCellView: UIView!

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupWrapperCellView()
        setupCell()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupCell(){
        labelText = UITextField()
        labelText.font = UIFont.boldSystemFont(ofSize: 20)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        
        toggleButton = UIButton()
        toggleButton.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        
        stackCell = UIStackView(arrangedSubviews: [toggleButton, labelText])
        stackCell.axis = .horizontal
        stackCell.alignment = .center
        stackCell.spacing = 10
        stackCell.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(stackCell)
    }
    
    

    
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
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
