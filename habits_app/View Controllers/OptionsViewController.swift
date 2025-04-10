import UIKit

//MARK: - View Controller Methods
class OptionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    ///UI Elements
    private let tableView = UITableView()
    private let separator = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .black
        
        self.title = "Goals"
       
        setupTableView()
        addTabBarSeparator()  // Add the separator above the tab bar
        
        // ✅ Add "+" and "-" buttons
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addHabitTapped))
        addButton.tintColor = .black

//        let removeButton = UIBarButtonItem(title: "−", style: .plain, target: self, action: #selector(toggleEditingMode))
//        removeButton.tintColor = .white  // ✅ Ensure visibility on black background

        navigationItem.rightBarButtonItems = [addButton]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Refresh")
        self.tableView.reloadData()
    }
}

//MARK: - Setup Table View Methods
extension OptionsViewController {
 
    private func setupTableView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 216/255, green: 219/255, blue: 216/255, alpha: 1.0).cgColor,
            UIColor(red: 226/255, green: 226/255, blue: 224/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds

        let gradientView = UIView(frame: view.bounds)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        view.insertSubview(gradientView, belowSubview: tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: "OptionsCell")

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -85)
        ])
    }
}

//MARK: - Table View Delegate and DataSource Methods
extension OptionsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.habits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as? OptionsTableViewCell else {
            return UITableViewCell()
        }

        let habit = DataManager.shared.habits[indexPath.row]
        cell.configure(title: habit.title, value: habit.value, progress: habit.progress, leftPercent: habit.leftPercentage, rightPercent: habit.rightPercentage, insurance: habit.insurance)
       // cell.contentView.backgroundColor = .black
       // cell.gradientLayer.frame = cell.cardView.bounds
       // cell.gradientLayer.cornerRadius = cell.cardView.layer.cornerRadius
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let habit = DataManager.shared.habits[indexPath.row]
        let goalViewController = GoalViewController()
        
        // Pass the selected habit to the GoalViewController
        goalViewController.habit = habit
        
        navigationController?.pushViewController(goalViewController, animated: true)
    }

}

//MARK: - Table View Edit Methods
extension OptionsViewController {
    
    @objc private func addHabitTapped() {
        DataManager.shared.addHabit(title: "New Habit", value: "$0", progress: 0.5, leftPercentage: "50%", rightPercentage: "50%", insurance: "Something")
        tableView.reloadData()  // ✅ Refresh UI after adding
    }
    
    @objc private func toggleEditingMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

   
    private func editHabit(at indexPath: IndexPath) {
        let habit = DataManager.shared.habits[indexPath.row]
        
        let alertController = UIAlertController(title: "Edit Habit", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = habit.title
        }
        alertController.addTextField { textField in
            textField.text = habit.value
            textField.keyboardType = .numberPad
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let title = alertController.textFields?[0].text,
                  let value = alertController.textFields?[1].text else { return }
            
            DataManager.shared.updateHabit(
                at: indexPath.row,
                title: title,
                value: value,
                progress: habit.progress,
                leftPercentage: habit.leftPercentage,
                rightPercentage: habit.rightPercentage
            )
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - Tab Bar Methods
extension OptionsViewController {
    private func addTabBarSeparator() {
        separator.backgroundColor = .gray
        separator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separator)

        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -84),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
}
