//
//  UIViewExtension.swift
//  BusSchedule
//
//  Created by alisandagdelen on 10.03.2018.
//  Copyright © 2018 alisandagdelen. All rights reserved.
//

import UIKit

extension UIView {
    
    // MARK: Return String
    static var nibName: String {
        return String(describing: self)
    }
    
    // MARK: Return UIView
    static var fromNib: UIView? {
        let nib = UINib(nibName:nibName, bundle:nil)
        let view = nib.instantiate(withOwner: nil, options: nil).first as? UIView
        return view
    }
}
