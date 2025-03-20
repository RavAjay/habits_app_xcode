//
//  TasksViewController.swift
//  habits_app
//
//  Created by Home PC on 3/15/25.
//

import UIKit

class TasksViewController: UIViewController {

    @IBOutlet weak var tasksTableView: UITableView!
    
    var habits = DataManager.shared.habits
    var gradientLayer: CAGradientLayer!
    var blurView: UIVisualEffectView! // Added blurView property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradientBackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Ensure the gradient layer resizes with the table view
        gradientLayer.frame = tasksTableView.bounds
    }
    
    func addGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = tasksTableView.bounds
        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.gray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let backgroundView = UIView(frame: tasksTableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tasksTableView.backgroundView = backgroundView
    }
    
}

//MARK: - Table View Methods
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TasksTableViewCell
        let habit = habits[indexPath.row]
        cell.taskTitleLabel.text = habit.title
        cell.taskTitleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 20)!
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    // Swipe action for "Done"
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, completionHandler) in
            // Mark the habit as done or remove it from the list (your desired logic)
            self.habits.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        doneAction.backgroundColor = .green // Set the action background color to green
        
        let swipeActions = UISwipeActionsConfiguration(actions: [doneAction])
        return swipeActions
    }
}
