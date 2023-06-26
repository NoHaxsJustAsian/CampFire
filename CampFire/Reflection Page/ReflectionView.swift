//
//  ReflectionView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit

class ReflectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var noteTextView: UITextView!
        
    var buttonAdd : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
