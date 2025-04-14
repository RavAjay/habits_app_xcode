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
        self.title = "Daily Goals"
        tasksTableView.delegate = self // Set delegate
        addGradientBackground() // Apply the gradient here
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Ensure the gradient layer resizes with the table view
       // gradientLayer.frame = tasksTableView.bounds
    }
    
    func addGradientBackground() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds // Use the view's bounds instead of just the table view's bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor] // Same gradient as in GoalViewController
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        let backgroundView = UIView(frame: view.bounds) // Use the view's bounds here as well
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        view.insertSubview(backgroundView, at: 0) // Insert the background view into the main view hierarchy
    }
    
    func showAccountabilityPopup(for habit: Habit) {
        let popupVC = UIViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        popupVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let popupView = UIView()
        popupView.backgroundColor = UIColor.systemGray6
        popupView.layer.cornerRadius = 16
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupVC.view.addSubview(popupView)
        
        NSLayoutConstraint.activate([
            popupView.centerXAnchor.constraint(equalTo: popupVC.view.centerXAnchor),
            popupView.centerYAnchor.constraint(equalTo: popupVC.view.centerYAnchor),
            popupView.widthAnchor.constraint(equalToConstant: 300),
            popupView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let titleLabel = UILabel()
        titleLabel.text = "Accountability"
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleLabel)
        
        let messageLabel = UILabel()
        messageLabel.text = "Did you do this today?"
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(messageLabel)
        
        let yesButton = UIButton(type: .system)
        yesButton.setTitle("Yes", for: .normal)
        yesButton.backgroundColor = .systemGreen
        yesButton.setTitleColor(.white, for: .normal)
        yesButton.layer.cornerRadius = 8
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(yesButton)
        
        let noButton = UIButton(type: .system)
        noButton.setTitle("No", for: .normal)
        noButton.backgroundColor = .systemRed
        noButton.setTitleColor(.white, for: .normal)
        noButton.layer.cornerRadius = 8
        noButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(noButton)
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("✕", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(cancelButton)
        
        cancelButton.addTarget(self, action: #selector(dismissPresentedController), for: .touchUpInside)
        
        yesButton.addTarget(self, action: #selector(dismissPresentedController), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(dismissPresentedController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
            
            yesButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            yesButton.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 30),
            yesButton.widthAnchor.constraint(equalToConstant: 100),
            yesButton.heightAnchor.constraint(equalToConstant: 40),
            
            noButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -20),
            noButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30),
            noButton.widthAnchor.constraint(equalToConstant: 100),
            noButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -8),
            cancelButton.widthAnchor.constraint(equalToConstant: 30),
            cancelButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        self.present(popupVC, animated: true, completion: nil)
    }

    @objc func dismissPresentedController() {
        self.dismiss(animated: true, completion: nil)
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
        cell.taskTitleLabel.font = FontManager.getFont(size: .medium)
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let habit = habits[indexPath.row]
        showAccountabilityPopup(for: habit)
        tableView.deselectRow(at: indexPath, animated: true)
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
