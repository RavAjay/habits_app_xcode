//
//  FirstViewController.swift
//  habits_app
//
//  Created by Home PC on 1/30/25.
//

import UIKit

class FirstViewController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSquare()
    }
    
    func addSquare() {
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = .blue
        self.view.addSubview(square)
        
        
        let square2 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        square.backgroundColor = .blue
        self.view.addSubview(square2)
        
        
    }
    
   
    
}
