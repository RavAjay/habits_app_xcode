import UIKit

//Learn to use collection view and pass data to the view controllers

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:Int? = nil
    
    let groups = ["Math", "Physics", "Computer Science", "Machine Learning"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController - viewdidLoad")
        
        view.addSubview(tableView)
        
        //setupTableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // 1
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "GroupTVCell")
        
        self.heightPlayer()
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(self.groups[indexPath.row])")
        //go to anothrer view controller and print the cell title in that view controller
        //three view controllers
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "detailsViewController") as? DetailsViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
           
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "First") as? FirstViewController {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 2
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTVCell", for: indexPath) as? CustomTableViewCell
        
       // cell?.accessoryType = .disclosureIndicator
//        let index = indexPath.row
//        cell?.groupLabel.text = groups[index]
//        cell?.chartImageView.image = UIImage(named: "bar_chart")
        cell!.groupLabel.text = self.groups[indexPath.row]
        cell!.detailsLabel.text = "123"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44+14
    }
    
    
}

extension ViewController {
    
    //Min
    func add(num1: Int = 2, num2: Int = 1) {
        let sum =  num1 + num2
        
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
