//
//  TasksViewController.swift
//  habits_app
//
//  Created by Home PC on 3/15/25.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    
    let habits = DataManager.shared.habits
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for family in UIFont.familyNames {
            print("Font Family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("-- \(name)")
            }
        }
    }
}

//MARK: - Table View Methods
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TasksTableViewCell
        let habit = habits[indexPath.row]//2
        cell.taskTitleLabel.text = habit.title
        cell.taskTitleLabel.font = UIFont(name: "PressStart2P-Regular", size: 17)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}


