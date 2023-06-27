//
//  ReflectionView.swift
//  CampFire
//
//  Created by Win Tongtawee on 6/25/23.
//

import UIKit

class ReflectionView: UIView {

    var noteTextView: UITextView!
    var buttonAdd : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.systemBackground
    
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
