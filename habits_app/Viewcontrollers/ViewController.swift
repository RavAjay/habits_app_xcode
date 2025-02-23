import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!

    var peopleCoordinator = PeopleCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "People"
        self.getData()
        self.setupTableView()
    }
}

//MARK: - Data Functions
extension ViewController {
    func getData() {
        
        self.peopleCoordinator.getPeopleInformatiom()
    }
}

//MARK: - Table View Functions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "GroupTVCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peopleCoordinator.people.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Go to another view controller
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTVCell", for: indexPath) as? CustomTableViewCell
        let person = self.peopleCoordinator.people[indexPath.row]
        cell!.groupLabel.text = person.name
        cell?.accessoryType = .disclosureIndicator
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}

//Model-View-ViewModel

