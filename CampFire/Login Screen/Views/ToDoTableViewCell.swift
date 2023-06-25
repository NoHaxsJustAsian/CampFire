import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelText: UILabel!
    var completeButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelText()
        setupCompleteButton()
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
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.font = UIFont.boldSystemFont(ofSize: 20)
        labelText.translatesAutoresizingMaskIntoConstraints = true
        wrapperCellView.addSubview(labelText)
    }
    
    //FIXME: make this a toggle button
    func setupCompleteButton(){
        completeButton = UIButton()
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelText.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelText.heightAnchor.constraint(equalToConstant: 20),
            labelText.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 30)
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
