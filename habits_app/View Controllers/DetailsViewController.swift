//
//  DetailsViewController.swift
//  habits_app
//
//  Created by Home PC on 1/30/25.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailsViewController - viewdidLoad")
        //Setup of UI elements
        //call the api
        //call the api
        //add a loader to the screen
        //when get the data
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

override func viewDidAppear(_ animated: Bool) {
        print("DetailsViewController - viewDidAppear")
        //Reload the UI elemnts with the content
    }
        
override func viewWillDisappear(_ animated: Bool) {
            print("DetailsViewController - viewWillDisappear")
    //Dinint all the useless variables
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("DetailsViewController - viewWillAppear")
        //You are going to call an API to get the data from the server
        //Loader
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("DetailsViewController - viewDidDisappear")
        //Save all the progress
    }
    
}

class titleLabel: UILabel {
}
