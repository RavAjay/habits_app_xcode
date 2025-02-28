import UIKit

//Learn to use collection view and pass data to the view controllers

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:Int? = nil
    
    let groups = ["Math", "Physics", "Computer Science", "Machine Learning"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController - viewDidLoad")

        // Set background color
        view.backgroundColor = .black
        tableView.backgroundColor = .black

        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none  // Remove cell dividers
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "GroupTVCell")

        setupMenuButton()  // Add the menu button at the bottom
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("ViewController - viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewController - viewWillAppear")
    }
        
    override func viewWillDisappear(_ animated: Bool) {
            print("ViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("ViewController - viewDidDisappear")
    }
    
    // 🔥 Add this at line ~50 (after viewDidDisappear)
    func setupMenuButton() {
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)  // Hamburger icon
        menuButton.tintColor = .white
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)

        view.addSubview(menuButton)

        NSLayoutConstraint.activate([
            menuButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 40),
            menuButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc func menuButtonTapped() {
        print("Menu button tapped")  // Replace this with desired action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewControllerIdentifiers = [
            "MathViewController",
            "PhysicsViewController",
            "ComputerScienceViewController",
            "MachineLearningViewController"
        ]
        
        // ✅ Check if the index is valid
        if indexPath.row < viewControllerIdentifiers.count {
            let selectedIdentifier = viewControllerIdentifiers[indexPath.row]
            
            let selectedVC = storyboard.instantiateViewController(withIdentifier: selectedIdentifier)
            navigationController?.pushViewController(selectedVC, animated: true)
        } else {
            // 🚀 Fallback: Navigate to FirstViewController if no valid index
            if let optionsVC = storyboard.instantiateViewController(withIdentifier: "Options") as? OptionsViewController {
                navigationController?.pushViewController(optionsVC, animated: true)
            }
        }
        
        // ✅ Deselect the row after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTVCell", for: indexPath) as? CustomTableViewCell
        

        cell!.groupLabel.text = self.groups[indexPath.row]
        cell!.groupLabel.font = UIFont.boldSystemFont(ofSize: 28)  // ✅ Bigger, bolder text
        cell!.groupLabel.textColor = .white
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // ✅ Increase cell height
    }
    
    
}

extension ViewController {
    
    //Min
    func add(num1: Int = 2, num2: Int = 1) {
        let sum = num1 + num2
        print("Sum: \(sum)")
    }
    
    //Min 10
    func heightPlayer(height: Int = 10) {
        
    }
    
    func processAPIResponse() {
        //API call
        self.data = 100
        let defaultv = 90
        
        print("data: \(self.data ?? defaultv)")
    }
    
}
