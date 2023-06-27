//
//  ReflectionView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit

class ReflectionView: UIView {

    var labelStack:UIStackView!
    var taskLabel: UILabel!
    var motivationLabel:UILabel!
    var moveLabel:UILabel!

    var buttonStack: UIStackView!
    var sundayButton: UIButton!
    var mondayButton: UIButton!
    var tuesdayButton: UIButton!
    var wednesdayButton: UIButton!
    var thursdayButton: UIButton!
    var fridayButton: UIButton!
    var saturdayButton: UIButton!

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemBackground
        setupLabelStack()
        setupButtonStack()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabelStack(){
        taskLabel = UILabel()
        taskLabel.text = "Task"
        
        motivationLabel = UILabel()
        motivationLabel.text = "Did you get everything done today?"
        
        moveLabel = UILabel()
        moveLabel.text = "Would you like to move this?"
        
        
        labelStack = UIStackView(arrangedSubviews: [taskLabel, motivationLabel,moveLabel])
        labelStack.axis = .vertical
        labelStack.alignment = .center
        labelStack.spacing = 30
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelStack)
    }
    
    func setupButtonStack(){
        sundayButton = UIButton(type: .system)
        sundayButton.tintColor = .orange
        sundayButton.configuration = .filled()
        sundayButton.setTitle("Sunday", for: .normal)
        
        mondayButton = UIButton(type: .system)
        mondayButton.tintColor = .orange
        mondayButton.configuration = .filled()
        mondayButton.setTitle("Monday", for: .normal)
        
        tuesdayButton = UIButton(type: .system)
        tuesdayButton.tintColor = .orange
        tuesdayButton.configuration = .filled()
        tuesdayButton.setTitle("Tuesday", for: .normal)
        
        wednesdayButton = UIButton(type: .system)
        wednesdayButton.tintColor = .orange
        wednesdayButton.configuration = .filled()
        wednesdayButton.setTitle("Wednesday", for: .normal)
        
        thursdayButton = UIButton(type: .system)
        thursdayButton.tintColor = .orange
        thursdayButton.configuration = .filled()
        thursdayButton.setTitle("Thursday", for: .normal)
        
        fridayButton = UIButton(type: .system)
        fridayButton.tintColor = .orange
        fridayButton.configuration = .filled()
        fridayButton.setTitle("Friday", for: .normal)
        
        saturdayButton = UIButton(type: .system)
        saturdayButton.tintColor = .orange
        saturdayButton.configuration = .filled()
        saturdayButton.setTitle("Saturday", for: .normal)
        
        buttonStack = UIStackView(arrangedSubviews: [sundayButton,mondayButton,tuesdayButton,wednesdayButton,thursdayButton,fridayButton,saturdayButton])
        buttonStack.axis = .vertical
        buttonStack.alignment = .center
        buttonStack.spacing = 5
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStack)
    }
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            labelStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            labelStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            buttonStack.topAnchor.constraint(equalTo: labelStack.bottomAnchor, constant: 20),
            buttonStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

}
