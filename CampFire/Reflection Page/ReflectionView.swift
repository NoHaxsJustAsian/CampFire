//
//  ReflectionView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit

class ReflectionView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func initConstraints() {
        NSLayoutConstraint.activate([
        

            
//            buttonAdd.bottomAnchor.constraint(equalTo:self.noteTextView.bottomAnchor, constant: 100.0),
//            buttonAdd.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//          //  textFieldAddName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            buttonAdd.widthAnchor.constraint(equalToConstant: 300),
//
//
//
//
//
//
//            reflectionTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
//            reflectionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
//            reflectionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20.0),
//            reflectionTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -200),
            
        ]
        )
    }
    

}
