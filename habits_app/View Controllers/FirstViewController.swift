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
        print("FirstViewController - viewdidLoad")
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
    
    override func viewDidAppear(_ animated: Bool) {
        print("FirstViewController - viewDidAppear")
    }
        
    override func viewWillDisappear(_ animated: Bool) {
            print("FirstViewController - viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("FirstViewController - viewWillAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("FirstViewController - viewDidDisappear")
    }
    
    
   
    
}
